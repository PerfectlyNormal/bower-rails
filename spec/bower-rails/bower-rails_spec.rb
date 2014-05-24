require 'spec_helper'

describe BowerRails do
  it 'should set default value for install_before_precompile option' do
    expect(BowerRails.install_before_precompile).to eq(false)
  end

  it 'should set default value for resolve_before_precompile option' do
    expect(BowerRails.resolve_before_precompile).to eq(false)
  end

  it 'should set default value for clean_before_precompile option' do
    expect(BowerRails.clean_before_precompile).to eq(false)
  end

  it 'should set default value for @tasks option' do
    expect(BowerRails.instance_variable_get(:@tasks)).to be_empty
  end

  describe '#configure' do
    before :each do
      BowerRails.instance_variable_set(:@tasks, [])
      BowerRails.configure do |bower_rails|
        bower_rails.install_before_precompile = false
        bower_rails.resolve_before_precompile = false
        bower_rails.clean_before_precompile = false
      end
    end

    describe '#install_before_precompile' do
      before do
        BowerRails.configure do |bower_rails|
          bower_rails.install_before_precompile = true
        end
      end

      it 'should set install_before_precompile option' do
        expect(BowerRails.install_before_precompile).to eq(true)
      end

      it 'should form correct tasks for enhancing assets:precompile' do
        expect(BowerRails.tasks).to eq(['bower:install'])
      end
    end

    describe '#resolve_before_precompile' do
      before do
        BowerRails.configure do |bower_rails|
          bower_rails.resolve_before_precompile = true
        end
      end

      it 'should set resolve_before_precompile option' do
        expect(BowerRails.resolve_before_precompile).to eq(true)
      end

      it 'should form correct tasks for enhancing assets:precompile' do
        expect(BowerRails.tasks).to eq(['bower:install', 'bower:resolve'])
      end
    end

    describe '#clean_before_precompile' do
      before do
        BowerRails.configure do |bower_rails|
          bower_rails.clean_before_precompile = true
        end
      end

      it 'should set clean_before_precompile option' do
        expect(BowerRails.clean_before_precompile).to eq(true)
      end

      it 'should form correct tasks for enhancing assets:precompile' do
        expect(BowerRails.tasks).to eq(['bower:install', 'bower:clean'])
      end
    end

    describe '#resolve_before_precompile and #clean_before_precompile' do
      before do
        BowerRails.configure do |bower_rails|
          bower_rails.resolve_before_precompile = true
          bower_rails.clean_before_precompile   = true
        end
      end

      it 'should form correct tasks for enhancing assets:precompile' do
        expect(BowerRails.tasks).to include('bower:install', 'bower:clean', 'bower:resolve')
      end

      it 'should has three tasks for enhancing' do
        expect(BowerRails.tasks.size).to eq(3)
      end
    end    
  end
end