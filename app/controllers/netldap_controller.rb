#require 'rubygems'
#gem 'ruby-net-ldap'
#gem 'net-ldap'
require 'net/ldap'

class NetldapController < ApplicationController
  #HOST='199.79.48.73'   - for dev1
  HOST='199.79.48.149'   # - for dev1video
  def authenticate
    username=params[:cn]
    password=params[:userPassword]
    cn=username.to_s
    userPassword=password.to_s
    dn="cn="+cn+",ou=users,ou=system"

    if request.post?
      @dn=dn
      @cn=cn
      @userPassword=userPassword

      user = ActiveDirectoryUser.authenticate(username,password)
      if user
        @success=1
        redirect_to addressbooks_path
      else
        @success=0
      end
    end

  end

  def index
    treebase= "ou=users,ou=system"
    attrs = ["cn", "sn", "userPassword"]
    filter = Net::LDAP::Filter.eq("cn", "*")
    directoryEntry="<table cellspacing=0 border=1><tr><th colspan=4>Entry Attribute</th></tr><tr><th>cn</th><th>sn</th><th>userPassword</th><th>Action</th></tr>"
    Net::LDAP.open( :host => HOST, :port => 10389, :auth => { :method => :simple, :username => 'uid=admin,ou=system', :password => 'secret' } ) do |ldap|
      ldap.search(:base => treebase, :filter => filter) do |entry|
        directoryEntry+="<tr>"
        directoryEntry+="<td>"+"#{entry.cn}"+"</td>"
        directoryEntry+="<td>"+"#{entry.sn}"+"</td>"
        directoryEntry+="<td>"+"#{entry.userPassword}"+"</td>"
        directoryEntry+="<td><a href='delete_entry?cn="+"#{entry.cn}"+"'>Delete</a> | <a href='edit_entry?cn="+"#{entry.cn}"+"'>Change Password</a></td>"
        directoryEntry+="</tr>"
      end
    end

    directoryEntry+="</table>"

    if request.post?
      render :text=> directoryEntry
    end

  end

  def edit_entry
    @cn=params[:cn].sub(/\["/,"").sub(/"\]/,"")
  end

  def modify_entry
    cn=params[:cn].to_s
    userPassword=params[:userPassword].to_s

    dn="cn="+cn+",ou=users,ou=system"

    Net::LDAP.open( :host => HOST, :port => 10389, :auth => { :method => :simple, :username => 'uid=admin,ou=system', :password => 'secret' } ) do |ldap|
      ldap.replace_attribute dn, :userPassword, userPassword
      @cn=cn
    end

  end

  def modify_entry
    cn=params[:cn].to_s
    userPassword=params[:userPassword].to_s

    dn="cn="+cn+",ou=users,ou=system"

    Net::LDAP.open( :host => HOST, :port => 10389, :auth => { :method => :simple, :username => 'uid=admin,ou=system', :password => 'secret' } ) do |ldap|
      ldap.replace_attribute dn, :userPassword, userPassword
      @cn=cn
    end

  end

  def delete_entry

    cn=params[:cn].sub(/\["/,"").sub(/"\]/,"")
    cn=cn.to_s

    dn="cn="+cn+",ou=users,ou=system"

    Net::LDAP.open( :host => HOST, :port => 10389, :auth => { :method => :simple, :username => 'uid=admin,ou=system', :password => 'secret' } ) do |ldap|

      ldap.delete :dn => dn
    end

  end

  def add_entry
    gn=params[:gn]
    sn=params[:sn]
    userPassword=params[:userPassword]
    cn=gn.to_s+sn.to_s
    dn="cn="+cn+",ou=users,ou=system"
    attr = {
        :cn => cn,
        :objectclass => ['top', 'person', 'organizationalPerson'],
        :sn => sn,
        :userPassword => userPassword
    }

    Net::LDAP.open( :host => HOST, :port => 10389, :auth => { :method => :simple, :username => 'uid=admin,ou=system', :password => 'secret' } ) do |ldap|
      begin
        ldap.add( :dn => dn, :attributes => attr )
        redirect_to addressbooks_path
      rescue Exception
        #$stderr.print "Directory entry already exists " + $!
      end
    end

  end

end

class ActiveDirectoryUser
  ### BEGIN CONFIGURATION ###
  SERVER = '199.79.48.73'   # Active Directory server name or IP
  PORT = 10389                    # Active Directory server port (default 389)
  BASE = 'ou=users,ou=system'    # Base to search from
  #DOMAIN = 'company.com'        # For simplified user@domain format login
                                ### END CONFIGURATION ###

  def self.authenticate(login, pass)
    return false if login.empty? or pass.empty?

    conn = Net::LDAP.new :host => SERVER,
                         :port => PORT,
                         :base => BASE,
                         :auth => { #:username => "cn=#{login}",
                                    :username => "cn=#{login},ou=users,ou=system",
                                    :password => pass,
                                    #:username => "uid=admin,ou=system",
                                    #:password => "secret",
                                    :method => :simple }
    if conn.bind
      return true
    else
      return false
    end
      # If we don't rescue this, Net::LDAP is decidedly ungraceful about failing
      # to connect to the server. We'd prefer to say authentication failed.
    rescue Net::LDAP::LdapError => e
    return false
  end
end