module NikePlus
  class Profile < Base
    attr_accessor :id, :firstName, :lastName, :email, :locale, :userType, :screenName,
        :login, :receiveEmail, :gender, :passwordQuestion, :passwordAnswer,
        :registrationSiteId, :temporaryPassword, :dobMonth, :dobDay, :dobYear,
        :mobileNumber, :mobileCarrier, :mobileScreenName,
        :homeAddress_address1, :homeAddress_address2, :homeAddress_address3,
        :homeAddress_city, :homeAddress_state, :homeAddress_postalCode,
        :homeAddress_country, :homeAddress_phoneNumber
    attr_reader :homeAddress


    def initialize(profile)
      profile.each_element_with_text do |e|
        send("#{e.name.sub('.', '_')}=", e.text)
      end
    end
  end
end