defmodule Eigr.Functions.Protocol.Status do
  @moduledoc false
  use Protobuf, enum: true, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      __unknown_fields__: [],
      name: "Status",
      options: nil,
      reserved_name: [],
      reserved_range: [],
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          __unknown_fields__: [],
          name: "UNKNOWN",
          number: 0,
          options: nil
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          __unknown_fields__: [],
          name: "OK",
          number: 1,
          options: nil
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          __unknown_fields__: [],
          name: "ACTOR_NOT_FOUND",
          number: 2,
          options: nil
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          __unknown_fields__: [],
          name: "ERROR",
          number: 3,
          options: nil
        }
      ]
    }
  end

  field(:UNKNOWN, 0)
  field(:OK, 1)
  field(:ACTOR_NOT_FOUND, 2)
  field(:ERROR, 3)
end

defmodule Eigr.Functions.Protocol.SpawnRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      __unknown_fields__: [],
      enum_type: [],
      extension: [],
      extension_range: [],
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "actorSystem",
          label: :LABEL_OPTIONAL,
          name: "actor_system",
          number: 2,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_MESSAGE,
          type_name: ".eigr.functions.protocol.actors.ActorSystem"
        }
      ],
      name: "SpawnRequest",
      nested_type: [],
      oneof_decl: [],
      options: nil,
      reserved_name: [],
      reserved_range: []
    }
  end

  field(:actor_system, 2,
    type: Eigr.Functions.Protocol.Actors.ActorSystem,
    json_name: "actorSystem"
  )
end

defmodule Eigr.Functions.Protocol.SpawnResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      __unknown_fields__: [],
      enum_type: [],
      extension: [],
      extension_range: [],
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "status",
          label: :LABEL_OPTIONAL,
          name: "status",
          number: 1,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_MESSAGE,
          type_name: ".eigr.functions.protocol.RequestStatus"
        }
      ],
      name: "SpawnResponse",
      nested_type: [],
      oneof_decl: [],
      options: nil,
      reserved_name: [],
      reserved_range: []
    }
  end

  field(:status, 1, type: Eigr.Functions.Protocol.RequestStatus)
end

defmodule Eigr.Functions.Protocol.RegistrationRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      __unknown_fields__: [],
      enum_type: [],
      extension: [],
      extension_range: [],
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "serviceInfo",
          label: :LABEL_OPTIONAL,
          name: "service_info",
          number: 1,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_MESSAGE,
          type_name: ".eigr.functions.protocol.ServiceInfo"
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "actorSystem",
          label: :LABEL_OPTIONAL,
          name: "actor_system",
          number: 2,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_MESSAGE,
          type_name: ".eigr.functions.protocol.actors.ActorSystem"
        }
      ],
      name: "RegistrationRequest",
      nested_type: [],
      oneof_decl: [],
      options: nil,
      reserved_name: [],
      reserved_range: []
    }
  end

  field(:service_info, 1, type: Eigr.Functions.Protocol.ServiceInfo, json_name: "serviceInfo")

  field(:actor_system, 2,
    type: Eigr.Functions.Protocol.Actors.ActorSystem,
    json_name: "actorSystem"
  )
end

defmodule Eigr.Functions.Protocol.ServiceInfo do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      __unknown_fields__: [],
      enum_type: [],
      extension: [],
      extension_range: [],
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "serviceName",
          label: :LABEL_OPTIONAL,
          name: "service_name",
          number: 1,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_STRING,
          type_name: nil
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "serviceVersion",
          label: :LABEL_OPTIONAL,
          name: "service_version",
          number: 2,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_STRING,
          type_name: nil
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "serviceRuntime",
          label: :LABEL_OPTIONAL,
          name: "service_runtime",
          number: 3,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_STRING,
          type_name: nil
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "supportLibraryName",
          label: :LABEL_OPTIONAL,
          name: "support_library_name",
          number: 4,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_STRING,
          type_name: nil
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "supportLibraryVersion",
          label: :LABEL_OPTIONAL,
          name: "support_library_version",
          number: 5,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_STRING,
          type_name: nil
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "protocolMajorVersion",
          label: :LABEL_OPTIONAL,
          name: "protocol_major_version",
          number: 6,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_INT32,
          type_name: nil
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "protocolMinorVersion",
          label: :LABEL_OPTIONAL,
          name: "protocol_minor_version",
          number: 7,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_INT32,
          type_name: nil
        }
      ],
      name: "ServiceInfo",
      nested_type: [],
      oneof_decl: [],
      options: nil,
      reserved_name: [],
      reserved_range: []
    }
  end

  field(:service_name, 1, type: :string, json_name: "serviceName")
  field(:service_version, 2, type: :string, json_name: "serviceVersion")
  field(:service_runtime, 3, type: :string, json_name: "serviceRuntime")
  field(:support_library_name, 4, type: :string, json_name: "supportLibraryName")
  field(:support_library_version, 5, type: :string, json_name: "supportLibraryVersion")
  field(:protocol_major_version, 6, type: :int32, json_name: "protocolMajorVersion")
  field(:protocol_minor_version, 7, type: :int32, json_name: "protocolMinorVersion")
end

defmodule Eigr.Functions.Protocol.ProxyInfo do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      __unknown_fields__: [],
      enum_type: [],
      extension: [],
      extension_range: [],
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "protocolMajorVersion",
          label: :LABEL_OPTIONAL,
          name: "protocol_major_version",
          number: 1,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_INT32,
          type_name: nil
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "protocolMinorVersion",
          label: :LABEL_OPTIONAL,
          name: "protocol_minor_version",
          number: 2,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_INT32,
          type_name: nil
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "proxyName",
          label: :LABEL_OPTIONAL,
          name: "proxy_name",
          number: 3,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_STRING,
          type_name: nil
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "proxyVersion",
          label: :LABEL_OPTIONAL,
          name: "proxy_version",
          number: 4,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_STRING,
          type_name: nil
        }
      ],
      name: "ProxyInfo",
      nested_type: [],
      oneof_decl: [],
      options: nil,
      reserved_name: [],
      reserved_range: []
    }
  end

  field(:protocol_major_version, 1, type: :int32, json_name: "protocolMajorVersion")
  field(:protocol_minor_version, 2, type: :int32, json_name: "protocolMinorVersion")
  field(:proxy_name, 3, type: :string, json_name: "proxyName")
  field(:proxy_version, 4, type: :string, json_name: "proxyVersion")
end

defmodule Eigr.Functions.Protocol.RegistrationResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      __unknown_fields__: [],
      enum_type: [],
      extension: [],
      extension_range: [],
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "status",
          label: :LABEL_OPTIONAL,
          name: "status",
          number: 1,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_MESSAGE,
          type_name: ".eigr.functions.protocol.RequestStatus"
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "proxyInfo",
          label: :LABEL_OPTIONAL,
          name: "proxy_info",
          number: 2,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_MESSAGE,
          type_name: ".eigr.functions.protocol.ProxyInfo"
        }
      ],
      name: "RegistrationResponse",
      nested_type: [],
      oneof_decl: [],
      options: nil,
      reserved_name: [],
      reserved_range: []
    }
  end

  field(:status, 1, type: Eigr.Functions.Protocol.RequestStatus)
  field(:proxy_info, 2, type: Eigr.Functions.Protocol.ProxyInfo, json_name: "proxyInfo")
end

defmodule Eigr.Functions.Protocol.Context do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      __unknown_fields__: [],
      enum_type: [],
      extension: [],
      extension_range: [],
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "state",
          label: :LABEL_OPTIONAL,
          name: "state",
          number: 1,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_MESSAGE,
          type_name: ".google.protobuf.Any"
        }
      ],
      name: "Context",
      nested_type: [],
      oneof_decl: [],
      options: nil,
      reserved_name: [],
      reserved_range: []
    }
  end

  field(:state, 1, type: Google.Protobuf.Any)
end

defmodule Eigr.Functions.Protocol.InvocationRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      __unknown_fields__: [],
      enum_type: [],
      extension: [],
      extension_range: [],
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "system",
          label: :LABEL_OPTIONAL,
          name: "system",
          number: 1,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_MESSAGE,
          type_name: ".eigr.functions.protocol.actors.ActorSystem"
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "actor",
          label: :LABEL_OPTIONAL,
          name: "actor",
          number: 2,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_MESSAGE,
          type_name: ".eigr.functions.protocol.actors.Actor"
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "commandName",
          label: :LABEL_OPTIONAL,
          name: "command_name",
          number: 3,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_STRING,
          type_name: nil
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "value",
          label: :LABEL_OPTIONAL,
          name: "value",
          number: 4,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_MESSAGE,
          type_name: ".google.protobuf.Any"
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "async",
          label: :LABEL_OPTIONAL,
          name: "async",
          number: 5,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_BOOL,
          type_name: nil
        }
      ],
      name: "InvocationRequest",
      nested_type: [],
      oneof_decl: [],
      options: nil,
      reserved_name: [],
      reserved_range: []
    }
  end

  field(:system, 1, type: Eigr.Functions.Protocol.Actors.ActorSystem)
  field(:actor, 2, type: Eigr.Functions.Protocol.Actors.Actor)
  field(:command_name, 3, type: :string, json_name: "commandName")
  field(:value, 4, type: Google.Protobuf.Any)
  field(:async, 5, type: :bool)
end

defmodule Eigr.Functions.Protocol.ActorInvocation do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      __unknown_fields__: [],
      enum_type: [],
      extension: [],
      extension_range: [],
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "actorName",
          label: :LABEL_OPTIONAL,
          name: "actor_name",
          number: 1,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_STRING,
          type_name: nil
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "actorSystem",
          label: :LABEL_OPTIONAL,
          name: "actor_system",
          number: 2,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_STRING,
          type_name: nil
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "commandName",
          label: :LABEL_OPTIONAL,
          name: "command_name",
          number: 3,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_STRING,
          type_name: nil
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "currentContext",
          label: :LABEL_OPTIONAL,
          name: "current_context",
          number: 4,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_MESSAGE,
          type_name: ".eigr.functions.protocol.Context"
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "value",
          label: :LABEL_OPTIONAL,
          name: "value",
          number: 5,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_MESSAGE,
          type_name: ".google.protobuf.Any"
        }
      ],
      name: "ActorInvocation",
      nested_type: [],
      oneof_decl: [],
      options: nil,
      reserved_name: [],
      reserved_range: []
    }
  end

  field(:actor_name, 1, type: :string, json_name: "actorName")
  field(:actor_system, 2, type: :string, json_name: "actorSystem")
  field(:command_name, 3, type: :string, json_name: "commandName")
  field(:current_context, 4, type: Eigr.Functions.Protocol.Context, json_name: "currentContext")
  field(:value, 5, type: Google.Protobuf.Any)
end

defmodule Eigr.Functions.Protocol.ActorInvocationResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      __unknown_fields__: [],
      enum_type: [],
      extension: [],
      extension_range: [],
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "actorName",
          label: :LABEL_OPTIONAL,
          name: "actor_name",
          number: 1,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_STRING,
          type_name: nil
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "actorSystem",
          label: :LABEL_OPTIONAL,
          name: "actor_system",
          number: 2,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_STRING,
          type_name: nil
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "updatedContext",
          label: :LABEL_OPTIONAL,
          name: "updated_context",
          number: 3,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_MESSAGE,
          type_name: ".eigr.functions.protocol.Context"
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "value",
          label: :LABEL_OPTIONAL,
          name: "value",
          number: 4,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_MESSAGE,
          type_name: ".google.protobuf.Any"
        }
      ],
      name: "ActorInvocationResponse",
      nested_type: [],
      oneof_decl: [],
      options: nil,
      reserved_name: [],
      reserved_range: []
    }
  end

  field(:actor_name, 1, type: :string, json_name: "actorName")
  field(:actor_system, 2, type: :string, json_name: "actorSystem")
  field(:updated_context, 3, type: Eigr.Functions.Protocol.Context, json_name: "updatedContext")
  field(:value, 4, type: Google.Protobuf.Any)
end

defmodule Eigr.Functions.Protocol.InvocationResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      __unknown_fields__: [],
      enum_type: [],
      extension: [],
      extension_range: [],
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "status",
          label: :LABEL_OPTIONAL,
          name: "status",
          number: 1,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_MESSAGE,
          type_name: ".eigr.functions.protocol.RequestStatus"
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "system",
          label: :LABEL_OPTIONAL,
          name: "system",
          number: 2,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_MESSAGE,
          type_name: ".eigr.functions.protocol.actors.ActorSystem"
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "actor",
          label: :LABEL_OPTIONAL,
          name: "actor",
          number: 3,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_MESSAGE,
          type_name: ".eigr.functions.protocol.actors.Actor"
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "value",
          label: :LABEL_OPTIONAL,
          name: "value",
          number: 4,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_MESSAGE,
          type_name: ".google.protobuf.Any"
        }
      ],
      name: "InvocationResponse",
      nested_type: [],
      oneof_decl: [],
      options: nil,
      reserved_name: [],
      reserved_range: []
    }
  end

  field(:status, 1, type: Eigr.Functions.Protocol.RequestStatus)
  field(:system, 2, type: Eigr.Functions.Protocol.Actors.ActorSystem)
  field(:actor, 3, type: Eigr.Functions.Protocol.Actors.Actor)
  field(:value, 4, type: Google.Protobuf.Any)
end

defmodule Eigr.Functions.Protocol.RequestStatus do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      __unknown_fields__: [],
      enum_type: [],
      extension: [],
      extension_range: [],
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "status",
          label: :LABEL_OPTIONAL,
          name: "status",
          number: 1,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_ENUM,
          type_name: ".eigr.functions.protocol.Status"
        },
        %Google.Protobuf.FieldDescriptorProto{
          __unknown_fields__: [],
          default_value: nil,
          extendee: nil,
          json_name: "message",
          label: :LABEL_OPTIONAL,
          name: "message",
          number: 2,
          oneof_index: nil,
          options: nil,
          proto3_optional: nil,
          type: :TYPE_STRING,
          type_name: nil
        }
      ],
      name: "RequestStatus",
      nested_type: [],
      oneof_decl: [],
      options: nil,
      reserved_name: [],
      reserved_range: []
    }
  end

  field(:status, 1, type: Eigr.Functions.Protocol.Status, enum: true)
  field(:message, 2, type: :string)
end
