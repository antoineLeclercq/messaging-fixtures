module Messaging
  module Fixtures
    class Handler
      include TestBench::Fixture
      include Initializer

      def entity_sequence
        return nil if entity.nil?
        entity.sequence
      end

      initializer :handler, :input_message, :entity, :entity_version, :time, :uuid, :action

      def self.build(handler, input_message, entity=nil, entity_version=nil, time: nil, uuid: nil, &action)
        instance = new(handler, input_message, entity, entity_version, time, uuid, action)

        set_store_entity(handler, entity, entity_version)
        set_clock_time(handler, time)
        set_identifier_uuid(handler, uuid)

        instance
      end

      def self.set_store_entity(handler, entity, entity_version)
        return if entity.nil?

        handler.store.add(entity.id, entity, entity_version)
      end

      def self.set_clock_time(handler, time)
        if time.nil?
          if handler.respond_to?(:clock)
            handler.clock.now = Defaults.time
          end
        else
          handler.clock.now = time
        end
      end

      def self.set_identifier_uuid(handler, uuid)
        if uuid.nil?
          if handler.respond_to?(:identifier)
            handler.identifier.set(Defaults.uuid)
          end
        else
          handler.identifier.set(uuid)
        end
      end

      def call
        context "Handler: #{handler.class.name.split('::').last}" do
          detail "Handler Class: #{handler.class.name}"

          detail "Entity Class: #{entity.class.name}"
          ## Problem: entity might not have sequence
          ## Maybe don't print this
          ## Could be something that a user puts in their own test code
          detail "Entity Sequence: #{entity_sequence.inspect}"

          handler.(input_message)

          if not action.nil?
            action.call(self)
          end
        end
      end

      def assert_write(message_class, &action)
        fixture = fixture(Write, handler.write, message_class, &action)

        output_message = fixture.message

        TestBench::Fixture.build(WrittenMessage, output_message, input_message, session: test_session)
      end
    end
  end
end
