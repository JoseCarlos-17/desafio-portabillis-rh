require 'rails_helper'

RSpec.describe User, type: :model do
  context 'enums' do
    it { is_expected.to define_enum_for(:access_level)
                        .with_values(client: 0, manager: 1) }
  end

  context 'attributes' do
    it { is_expected.to have_db_column(:name) }
    it { is_expected.to have_db_column(:email) }
    it { is_expected.to have_db_column(:active) }
  end
end
