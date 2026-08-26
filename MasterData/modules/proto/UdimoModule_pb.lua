-- chunkname: @modules/proto/UdimoModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.UdimoModule_pb", package.seeall)

local UdimoModule_pb = {}

UdimoModule_pb.UDIMODECORATIONNO_MSG = protobuf.Descriptor()
UdimoModule_pb.UDIMODECORATIONNODECORATIONIDFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.UDIMODECORATIONNOISUSEFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.WEATHINFOPUSH_MSG = protobuf.Descriptor()
UdimoModule_pb.WEATHINFOPUSHWEATHERFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.WEATHERNO_MSG = protobuf.Descriptor()
UdimoModule_pb.WEATHERNOLATFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.WEATHERNOLONFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.WEATHERNOTEMPFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.WEATHERNOWEATHERIDFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.WEATHERNOWINDLEVELFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.WEATHERNOSUNRISEFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.WEATHERNOSUNDOWNFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.UDIMOBACKGROUNDNO_MSG = protobuf.Descriptor()
UdimoModule_pb.UDIMOBACKGROUNDNOBACKGROUNDIDFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.UDIMOBACKGROUNDNOISUSEFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.UDIMONO_MSG = protobuf.Descriptor()
UdimoModule_pb.UDIMONOUDIMOIDFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.UDIMONOISUSEFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.UDIMONOGETTIMEFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.UDIMONOFIGHTCOUNTFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.UDIMONOHEROCOVERDAYFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.UDIMONOASSISTCOUNTFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.UDIMONOTRAINCRITTERCOUNTFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.GETUDIMOINFOREPLY_MSG = protobuf.Descriptor()
UdimoModule_pb.GETUDIMOINFOREPLYUDIMOSFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.GETUDIMOINFOREPLYBACKGROUNDSFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.GETUDIMOINFOREPLYDECORATIONSFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.GETUDIMOINFOREPLYWEATHERFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.USEUDIMOREQUEST_MSG = protobuf.Descriptor()
UdimoModule_pb.USEUDIMOREQUESTUSEUDIMOIDSFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.USEBACKGROUNDREPLY_MSG = protobuf.Descriptor()
UdimoModule_pb.USEBACKGROUNDREPLYUSEBACKGROUNDIDFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.GETUDIMOINFOREQUEST_MSG = protobuf.Descriptor()
UdimoModule_pb.GETUDIMOINFOREQUESTLATFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.GETUDIMOINFOREQUESTLONFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.USEUDIMOREPLY_MSG = protobuf.Descriptor()
UdimoModule_pb.USEUDIMOREPLYUSEUDIMOIDSFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.USEDECORATIONREPLY_MSG = protobuf.Descriptor()
UdimoModule_pb.USEDECORATIONREPLYUSEDECORATIONIDFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.USEDECORATIONREPLYREMOVEDECORATIONIDFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.USEDECORATIONREQUEST_MSG = protobuf.Descriptor()
UdimoModule_pb.USEDECORATIONREQUESTUSEDECORATIONIDFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.USEDECORATIONREQUESTREMOVEDECORATIONIDFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.USEBACKGROUNDREQUEST_MSG = protobuf.Descriptor()
UdimoModule_pb.USEBACKGROUNDREQUESTUSEBACKGROUNDIDFIELD = protobuf.FieldDescriptor()
UdimoModule_pb.UDIMODECORATIONNODECORATIONIDFIELD.name = "decorationId"
UdimoModule_pb.UDIMODECORATIONNODECORATIONIDFIELD.full_name = ".UdimoDecorationNO.decorationId"
UdimoModule_pb.UDIMODECORATIONNODECORATIONIDFIELD.number = 1
UdimoModule_pb.UDIMODECORATIONNODECORATIONIDFIELD.index = 0
UdimoModule_pb.UDIMODECORATIONNODECORATIONIDFIELD.label = 1
UdimoModule_pb.UDIMODECORATIONNODECORATIONIDFIELD.has_default_value = false
UdimoModule_pb.UDIMODECORATIONNODECORATIONIDFIELD.default_value = 0
UdimoModule_pb.UDIMODECORATIONNODECORATIONIDFIELD.type = 5
UdimoModule_pb.UDIMODECORATIONNODECORATIONIDFIELD.cpp_type = 1
UdimoModule_pb.UDIMODECORATIONNOISUSEFIELD.name = "isUse"
UdimoModule_pb.UDIMODECORATIONNOISUSEFIELD.full_name = ".UdimoDecorationNO.isUse"
UdimoModule_pb.UDIMODECORATIONNOISUSEFIELD.number = 2
UdimoModule_pb.UDIMODECORATIONNOISUSEFIELD.index = 1
UdimoModule_pb.UDIMODECORATIONNOISUSEFIELD.label = 1
UdimoModule_pb.UDIMODECORATIONNOISUSEFIELD.has_default_value = false
UdimoModule_pb.UDIMODECORATIONNOISUSEFIELD.default_value = 0
UdimoModule_pb.UDIMODECORATIONNOISUSEFIELD.type = 5
UdimoModule_pb.UDIMODECORATIONNOISUSEFIELD.cpp_type = 1
UdimoModule_pb.UDIMODECORATIONNO_MSG.name = "UdimoDecorationNO"
UdimoModule_pb.UDIMODECORATIONNO_MSG.full_name = ".UdimoDecorationNO"
UdimoModule_pb.UDIMODECORATIONNO_MSG.nested_types = {}
UdimoModule_pb.UDIMODECORATIONNO_MSG.enum_types = {}
UdimoModule_pb.UDIMODECORATIONNO_MSG.fields = {
	UdimoModule_pb.UDIMODECORATIONNODECORATIONIDFIELD,
	UdimoModule_pb.UDIMODECORATIONNOISUSEFIELD
}
UdimoModule_pb.UDIMODECORATIONNO_MSG.is_extendable = false
UdimoModule_pb.UDIMODECORATIONNO_MSG.extensions = {}
UdimoModule_pb.WEATHINFOPUSHWEATHERFIELD.name = "weather"
UdimoModule_pb.WEATHINFOPUSHWEATHERFIELD.full_name = ".WeathInfoPush.weather"
UdimoModule_pb.WEATHINFOPUSHWEATHERFIELD.number = 1
UdimoModule_pb.WEATHINFOPUSHWEATHERFIELD.index = 0
UdimoModule_pb.WEATHINFOPUSHWEATHERFIELD.label = 1
UdimoModule_pb.WEATHINFOPUSHWEATHERFIELD.has_default_value = false
UdimoModule_pb.WEATHINFOPUSHWEATHERFIELD.default_value = nil
UdimoModule_pb.WEATHINFOPUSHWEATHERFIELD.message_type = UdimoModule_pb.WEATHERNO_MSG
UdimoModule_pb.WEATHINFOPUSHWEATHERFIELD.type = 11
UdimoModule_pb.WEATHINFOPUSHWEATHERFIELD.cpp_type = 10
UdimoModule_pb.WEATHINFOPUSH_MSG.name = "WeathInfoPush"
UdimoModule_pb.WEATHINFOPUSH_MSG.full_name = ".WeathInfoPush"
UdimoModule_pb.WEATHINFOPUSH_MSG.nested_types = {}
UdimoModule_pb.WEATHINFOPUSH_MSG.enum_types = {}
UdimoModule_pb.WEATHINFOPUSH_MSG.fields = {
	UdimoModule_pb.WEATHINFOPUSHWEATHERFIELD
}
UdimoModule_pb.WEATHINFOPUSH_MSG.is_extendable = false
UdimoModule_pb.WEATHINFOPUSH_MSG.extensions = {}
UdimoModule_pb.WEATHERNOLATFIELD.name = "lat"
UdimoModule_pb.WEATHERNOLATFIELD.full_name = ".WeatherNO.lat"
UdimoModule_pb.WEATHERNOLATFIELD.number = 1
UdimoModule_pb.WEATHERNOLATFIELD.index = 0
UdimoModule_pb.WEATHERNOLATFIELD.label = 1
UdimoModule_pb.WEATHERNOLATFIELD.has_default_value = false
UdimoModule_pb.WEATHERNOLATFIELD.default_value = ""
UdimoModule_pb.WEATHERNOLATFIELD.type = 9
UdimoModule_pb.WEATHERNOLATFIELD.cpp_type = 9
UdimoModule_pb.WEATHERNOLONFIELD.name = "lon"
UdimoModule_pb.WEATHERNOLONFIELD.full_name = ".WeatherNO.lon"
UdimoModule_pb.WEATHERNOLONFIELD.number = 2
UdimoModule_pb.WEATHERNOLONFIELD.index = 1
UdimoModule_pb.WEATHERNOLONFIELD.label = 1
UdimoModule_pb.WEATHERNOLONFIELD.has_default_value = false
UdimoModule_pb.WEATHERNOLONFIELD.default_value = ""
UdimoModule_pb.WEATHERNOLONFIELD.type = 9
UdimoModule_pb.WEATHERNOLONFIELD.cpp_type = 9
UdimoModule_pb.WEATHERNOTEMPFIELD.name = "temp"
UdimoModule_pb.WEATHERNOTEMPFIELD.full_name = ".WeatherNO.temp"
UdimoModule_pb.WEATHERNOTEMPFIELD.number = 3
UdimoModule_pb.WEATHERNOTEMPFIELD.index = 2
UdimoModule_pb.WEATHERNOTEMPFIELD.label = 1
UdimoModule_pb.WEATHERNOTEMPFIELD.has_default_value = false
UdimoModule_pb.WEATHERNOTEMPFIELD.default_value = ""
UdimoModule_pb.WEATHERNOTEMPFIELD.type = 9
UdimoModule_pb.WEATHERNOTEMPFIELD.cpp_type = 9
UdimoModule_pb.WEATHERNOWEATHERIDFIELD.name = "weatherId"
UdimoModule_pb.WEATHERNOWEATHERIDFIELD.full_name = ".WeatherNO.weatherId"
UdimoModule_pb.WEATHERNOWEATHERIDFIELD.number = 4
UdimoModule_pb.WEATHERNOWEATHERIDFIELD.index = 3
UdimoModule_pb.WEATHERNOWEATHERIDFIELD.label = 1
UdimoModule_pb.WEATHERNOWEATHERIDFIELD.has_default_value = false
UdimoModule_pb.WEATHERNOWEATHERIDFIELD.default_value = 0
UdimoModule_pb.WEATHERNOWEATHERIDFIELD.type = 5
UdimoModule_pb.WEATHERNOWEATHERIDFIELD.cpp_type = 1
UdimoModule_pb.WEATHERNOWINDLEVELFIELD.name = "windLevel"
UdimoModule_pb.WEATHERNOWINDLEVELFIELD.full_name = ".WeatherNO.windLevel"
UdimoModule_pb.WEATHERNOWINDLEVELFIELD.number = 5
UdimoModule_pb.WEATHERNOWINDLEVELFIELD.index = 4
UdimoModule_pb.WEATHERNOWINDLEVELFIELD.label = 1
UdimoModule_pb.WEATHERNOWINDLEVELFIELD.has_default_value = false
UdimoModule_pb.WEATHERNOWINDLEVELFIELD.default_value = 0
UdimoModule_pb.WEATHERNOWINDLEVELFIELD.type = 5
UdimoModule_pb.WEATHERNOWINDLEVELFIELD.cpp_type = 1
UdimoModule_pb.WEATHERNOSUNRISEFIELD.name = "sunRise"
UdimoModule_pb.WEATHERNOSUNRISEFIELD.full_name = ".WeatherNO.sunRise"
UdimoModule_pb.WEATHERNOSUNRISEFIELD.number = 6
UdimoModule_pb.WEATHERNOSUNRISEFIELD.index = 5
UdimoModule_pb.WEATHERNOSUNRISEFIELD.label = 1
UdimoModule_pb.WEATHERNOSUNRISEFIELD.has_default_value = false
UdimoModule_pb.WEATHERNOSUNRISEFIELD.default_value = 0
UdimoModule_pb.WEATHERNOSUNRISEFIELD.type = 3
UdimoModule_pb.WEATHERNOSUNRISEFIELD.cpp_type = 2
UdimoModule_pb.WEATHERNOSUNDOWNFIELD.name = "sunDown"
UdimoModule_pb.WEATHERNOSUNDOWNFIELD.full_name = ".WeatherNO.sunDown"
UdimoModule_pb.WEATHERNOSUNDOWNFIELD.number = 7
UdimoModule_pb.WEATHERNOSUNDOWNFIELD.index = 6
UdimoModule_pb.WEATHERNOSUNDOWNFIELD.label = 1
UdimoModule_pb.WEATHERNOSUNDOWNFIELD.has_default_value = false
UdimoModule_pb.WEATHERNOSUNDOWNFIELD.default_value = 0
UdimoModule_pb.WEATHERNOSUNDOWNFIELD.type = 3
UdimoModule_pb.WEATHERNOSUNDOWNFIELD.cpp_type = 2
UdimoModule_pb.WEATHERNO_MSG.name = "WeatherNO"
UdimoModule_pb.WEATHERNO_MSG.full_name = ".WeatherNO"
UdimoModule_pb.WEATHERNO_MSG.nested_types = {}
UdimoModule_pb.WEATHERNO_MSG.enum_types = {}
UdimoModule_pb.WEATHERNO_MSG.fields = {
	UdimoModule_pb.WEATHERNOLATFIELD,
	UdimoModule_pb.WEATHERNOLONFIELD,
	UdimoModule_pb.WEATHERNOTEMPFIELD,
	UdimoModule_pb.WEATHERNOWEATHERIDFIELD,
	UdimoModule_pb.WEATHERNOWINDLEVELFIELD,
	UdimoModule_pb.WEATHERNOSUNRISEFIELD,
	UdimoModule_pb.WEATHERNOSUNDOWNFIELD
}
UdimoModule_pb.WEATHERNO_MSG.is_extendable = false
UdimoModule_pb.WEATHERNO_MSG.extensions = {}
UdimoModule_pb.UDIMOBACKGROUNDNOBACKGROUNDIDFIELD.name = "backgroundId"
UdimoModule_pb.UDIMOBACKGROUNDNOBACKGROUNDIDFIELD.full_name = ".UdimoBackgroundNO.backgroundId"
UdimoModule_pb.UDIMOBACKGROUNDNOBACKGROUNDIDFIELD.number = 1
UdimoModule_pb.UDIMOBACKGROUNDNOBACKGROUNDIDFIELD.index = 0
UdimoModule_pb.UDIMOBACKGROUNDNOBACKGROUNDIDFIELD.label = 1
UdimoModule_pb.UDIMOBACKGROUNDNOBACKGROUNDIDFIELD.has_default_value = false
UdimoModule_pb.UDIMOBACKGROUNDNOBACKGROUNDIDFIELD.default_value = 0
UdimoModule_pb.UDIMOBACKGROUNDNOBACKGROUNDIDFIELD.type = 5
UdimoModule_pb.UDIMOBACKGROUNDNOBACKGROUNDIDFIELD.cpp_type = 1
UdimoModule_pb.UDIMOBACKGROUNDNOISUSEFIELD.name = "isUse"
UdimoModule_pb.UDIMOBACKGROUNDNOISUSEFIELD.full_name = ".UdimoBackgroundNO.isUse"
UdimoModule_pb.UDIMOBACKGROUNDNOISUSEFIELD.number = 2
UdimoModule_pb.UDIMOBACKGROUNDNOISUSEFIELD.index = 1
UdimoModule_pb.UDIMOBACKGROUNDNOISUSEFIELD.label = 1
UdimoModule_pb.UDIMOBACKGROUNDNOISUSEFIELD.has_default_value = false
UdimoModule_pb.UDIMOBACKGROUNDNOISUSEFIELD.default_value = 0
UdimoModule_pb.UDIMOBACKGROUNDNOISUSEFIELD.type = 5
UdimoModule_pb.UDIMOBACKGROUNDNOISUSEFIELD.cpp_type = 1
UdimoModule_pb.UDIMOBACKGROUNDNO_MSG.name = "UdimoBackgroundNO"
UdimoModule_pb.UDIMOBACKGROUNDNO_MSG.full_name = ".UdimoBackgroundNO"
UdimoModule_pb.UDIMOBACKGROUNDNO_MSG.nested_types = {}
UdimoModule_pb.UDIMOBACKGROUNDNO_MSG.enum_types = {}
UdimoModule_pb.UDIMOBACKGROUNDNO_MSG.fields = {
	UdimoModule_pb.UDIMOBACKGROUNDNOBACKGROUNDIDFIELD,
	UdimoModule_pb.UDIMOBACKGROUNDNOISUSEFIELD
}
UdimoModule_pb.UDIMOBACKGROUNDNO_MSG.is_extendable = false
UdimoModule_pb.UDIMOBACKGROUNDNO_MSG.extensions = {}
UdimoModule_pb.UDIMONOUDIMOIDFIELD.name = "udimoId"
UdimoModule_pb.UDIMONOUDIMOIDFIELD.full_name = ".UdimoNO.udimoId"
UdimoModule_pb.UDIMONOUDIMOIDFIELD.number = 1
UdimoModule_pb.UDIMONOUDIMOIDFIELD.index = 0
UdimoModule_pb.UDIMONOUDIMOIDFIELD.label = 1
UdimoModule_pb.UDIMONOUDIMOIDFIELD.has_default_value = false
UdimoModule_pb.UDIMONOUDIMOIDFIELD.default_value = 0
UdimoModule_pb.UDIMONOUDIMOIDFIELD.type = 5
UdimoModule_pb.UDIMONOUDIMOIDFIELD.cpp_type = 1
UdimoModule_pb.UDIMONOISUSEFIELD.name = "isUse"
UdimoModule_pb.UDIMONOISUSEFIELD.full_name = ".UdimoNO.isUse"
UdimoModule_pb.UDIMONOISUSEFIELD.number = 2
UdimoModule_pb.UDIMONOISUSEFIELD.index = 1
UdimoModule_pb.UDIMONOISUSEFIELD.label = 1
UdimoModule_pb.UDIMONOISUSEFIELD.has_default_value = false
UdimoModule_pb.UDIMONOISUSEFIELD.default_value = 0
UdimoModule_pb.UDIMONOISUSEFIELD.type = 5
UdimoModule_pb.UDIMONOISUSEFIELD.cpp_type = 1
UdimoModule_pb.UDIMONOGETTIMEFIELD.name = "getTime"
UdimoModule_pb.UDIMONOGETTIMEFIELD.full_name = ".UdimoNO.getTime"
UdimoModule_pb.UDIMONOGETTIMEFIELD.number = 3
UdimoModule_pb.UDIMONOGETTIMEFIELD.index = 2
UdimoModule_pb.UDIMONOGETTIMEFIELD.label = 1
UdimoModule_pb.UDIMONOGETTIMEFIELD.has_default_value = false
UdimoModule_pb.UDIMONOGETTIMEFIELD.default_value = 0
UdimoModule_pb.UDIMONOGETTIMEFIELD.type = 3
UdimoModule_pb.UDIMONOGETTIMEFIELD.cpp_type = 2
UdimoModule_pb.UDIMONOFIGHTCOUNTFIELD.name = "fightCount"
UdimoModule_pb.UDIMONOFIGHTCOUNTFIELD.full_name = ".UdimoNO.fightCount"
UdimoModule_pb.UDIMONOFIGHTCOUNTFIELD.number = 4
UdimoModule_pb.UDIMONOFIGHTCOUNTFIELD.index = 3
UdimoModule_pb.UDIMONOFIGHTCOUNTFIELD.label = 1
UdimoModule_pb.UDIMONOFIGHTCOUNTFIELD.has_default_value = false
UdimoModule_pb.UDIMONOFIGHTCOUNTFIELD.default_value = 0
UdimoModule_pb.UDIMONOFIGHTCOUNTFIELD.type = 5
UdimoModule_pb.UDIMONOFIGHTCOUNTFIELD.cpp_type = 1
UdimoModule_pb.UDIMONOHEROCOVERDAYFIELD.name = "heroCoverDay"
UdimoModule_pb.UDIMONOHEROCOVERDAYFIELD.full_name = ".UdimoNO.heroCoverDay"
UdimoModule_pb.UDIMONOHEROCOVERDAYFIELD.number = 5
UdimoModule_pb.UDIMONOHEROCOVERDAYFIELD.index = 4
UdimoModule_pb.UDIMONOHEROCOVERDAYFIELD.label = 1
UdimoModule_pb.UDIMONOHEROCOVERDAYFIELD.has_default_value = false
UdimoModule_pb.UDIMONOHEROCOVERDAYFIELD.default_value = 0
UdimoModule_pb.UDIMONOHEROCOVERDAYFIELD.type = 5
UdimoModule_pb.UDIMONOHEROCOVERDAYFIELD.cpp_type = 1
UdimoModule_pb.UDIMONOASSISTCOUNTFIELD.name = "assistCount"
UdimoModule_pb.UDIMONOASSISTCOUNTFIELD.full_name = ".UdimoNO.assistCount"
UdimoModule_pb.UDIMONOASSISTCOUNTFIELD.number = 6
UdimoModule_pb.UDIMONOASSISTCOUNTFIELD.index = 5
UdimoModule_pb.UDIMONOASSISTCOUNTFIELD.label = 1
UdimoModule_pb.UDIMONOASSISTCOUNTFIELD.has_default_value = false
UdimoModule_pb.UDIMONOASSISTCOUNTFIELD.default_value = 0
UdimoModule_pb.UDIMONOASSISTCOUNTFIELD.type = 5
UdimoModule_pb.UDIMONOASSISTCOUNTFIELD.cpp_type = 1
UdimoModule_pb.UDIMONOTRAINCRITTERCOUNTFIELD.name = "trainCritterCount"
UdimoModule_pb.UDIMONOTRAINCRITTERCOUNTFIELD.full_name = ".UdimoNO.trainCritterCount"
UdimoModule_pb.UDIMONOTRAINCRITTERCOUNTFIELD.number = 7
UdimoModule_pb.UDIMONOTRAINCRITTERCOUNTFIELD.index = 6
UdimoModule_pb.UDIMONOTRAINCRITTERCOUNTFIELD.label = 1
UdimoModule_pb.UDIMONOTRAINCRITTERCOUNTFIELD.has_default_value = false
UdimoModule_pb.UDIMONOTRAINCRITTERCOUNTFIELD.default_value = 0
UdimoModule_pb.UDIMONOTRAINCRITTERCOUNTFIELD.type = 5
UdimoModule_pb.UDIMONOTRAINCRITTERCOUNTFIELD.cpp_type = 1
UdimoModule_pb.UDIMONO_MSG.name = "UdimoNO"
UdimoModule_pb.UDIMONO_MSG.full_name = ".UdimoNO"
UdimoModule_pb.UDIMONO_MSG.nested_types = {}
UdimoModule_pb.UDIMONO_MSG.enum_types = {}
UdimoModule_pb.UDIMONO_MSG.fields = {
	UdimoModule_pb.UDIMONOUDIMOIDFIELD,
	UdimoModule_pb.UDIMONOISUSEFIELD,
	UdimoModule_pb.UDIMONOGETTIMEFIELD,
	UdimoModule_pb.UDIMONOFIGHTCOUNTFIELD,
	UdimoModule_pb.UDIMONOHEROCOVERDAYFIELD,
	UdimoModule_pb.UDIMONOASSISTCOUNTFIELD,
	UdimoModule_pb.UDIMONOTRAINCRITTERCOUNTFIELD
}
UdimoModule_pb.UDIMONO_MSG.is_extendable = false
UdimoModule_pb.UDIMONO_MSG.extensions = {}
UdimoModule_pb.GETUDIMOINFOREPLYUDIMOSFIELD.name = "udimos"
UdimoModule_pb.GETUDIMOINFOREPLYUDIMOSFIELD.full_name = ".GetUdimoInfoReply.udimos"
UdimoModule_pb.GETUDIMOINFOREPLYUDIMOSFIELD.number = 1
UdimoModule_pb.GETUDIMOINFOREPLYUDIMOSFIELD.index = 0
UdimoModule_pb.GETUDIMOINFOREPLYUDIMOSFIELD.label = 3
UdimoModule_pb.GETUDIMOINFOREPLYUDIMOSFIELD.has_default_value = false
UdimoModule_pb.GETUDIMOINFOREPLYUDIMOSFIELD.default_value = {}
UdimoModule_pb.GETUDIMOINFOREPLYUDIMOSFIELD.message_type = UdimoModule_pb.UDIMONO_MSG
UdimoModule_pb.GETUDIMOINFOREPLYUDIMOSFIELD.type = 11
UdimoModule_pb.GETUDIMOINFOREPLYUDIMOSFIELD.cpp_type = 10
UdimoModule_pb.GETUDIMOINFOREPLYBACKGROUNDSFIELD.name = "backgrounds"
UdimoModule_pb.GETUDIMOINFOREPLYBACKGROUNDSFIELD.full_name = ".GetUdimoInfoReply.backgrounds"
UdimoModule_pb.GETUDIMOINFOREPLYBACKGROUNDSFIELD.number = 2
UdimoModule_pb.GETUDIMOINFOREPLYBACKGROUNDSFIELD.index = 1
UdimoModule_pb.GETUDIMOINFOREPLYBACKGROUNDSFIELD.label = 3
UdimoModule_pb.GETUDIMOINFOREPLYBACKGROUNDSFIELD.has_default_value = false
UdimoModule_pb.GETUDIMOINFOREPLYBACKGROUNDSFIELD.default_value = {}
UdimoModule_pb.GETUDIMOINFOREPLYBACKGROUNDSFIELD.message_type = UdimoModule_pb.UDIMOBACKGROUNDNO_MSG
UdimoModule_pb.GETUDIMOINFOREPLYBACKGROUNDSFIELD.type = 11
UdimoModule_pb.GETUDIMOINFOREPLYBACKGROUNDSFIELD.cpp_type = 10
UdimoModule_pb.GETUDIMOINFOREPLYDECORATIONSFIELD.name = "decorations"
UdimoModule_pb.GETUDIMOINFOREPLYDECORATIONSFIELD.full_name = ".GetUdimoInfoReply.decorations"
UdimoModule_pb.GETUDIMOINFOREPLYDECORATIONSFIELD.number = 3
UdimoModule_pb.GETUDIMOINFOREPLYDECORATIONSFIELD.index = 2
UdimoModule_pb.GETUDIMOINFOREPLYDECORATIONSFIELD.label = 3
UdimoModule_pb.GETUDIMOINFOREPLYDECORATIONSFIELD.has_default_value = false
UdimoModule_pb.GETUDIMOINFOREPLYDECORATIONSFIELD.default_value = {}
UdimoModule_pb.GETUDIMOINFOREPLYDECORATIONSFIELD.message_type = UdimoModule_pb.UDIMODECORATIONNO_MSG
UdimoModule_pb.GETUDIMOINFOREPLYDECORATIONSFIELD.type = 11
UdimoModule_pb.GETUDIMOINFOREPLYDECORATIONSFIELD.cpp_type = 10
UdimoModule_pb.GETUDIMOINFOREPLYWEATHERFIELD.name = "weather"
UdimoModule_pb.GETUDIMOINFOREPLYWEATHERFIELD.full_name = ".GetUdimoInfoReply.weather"
UdimoModule_pb.GETUDIMOINFOREPLYWEATHERFIELD.number = 4
UdimoModule_pb.GETUDIMOINFOREPLYWEATHERFIELD.index = 3
UdimoModule_pb.GETUDIMOINFOREPLYWEATHERFIELD.label = 1
UdimoModule_pb.GETUDIMOINFOREPLYWEATHERFIELD.has_default_value = false
UdimoModule_pb.GETUDIMOINFOREPLYWEATHERFIELD.default_value = nil
UdimoModule_pb.GETUDIMOINFOREPLYWEATHERFIELD.message_type = UdimoModule_pb.WEATHERNO_MSG
UdimoModule_pb.GETUDIMOINFOREPLYWEATHERFIELD.type = 11
UdimoModule_pb.GETUDIMOINFOREPLYWEATHERFIELD.cpp_type = 10
UdimoModule_pb.GETUDIMOINFOREPLY_MSG.name = "GetUdimoInfoReply"
UdimoModule_pb.GETUDIMOINFOREPLY_MSG.full_name = ".GetUdimoInfoReply"
UdimoModule_pb.GETUDIMOINFOREPLY_MSG.nested_types = {}
UdimoModule_pb.GETUDIMOINFOREPLY_MSG.enum_types = {}
UdimoModule_pb.GETUDIMOINFOREPLY_MSG.fields = {
	UdimoModule_pb.GETUDIMOINFOREPLYUDIMOSFIELD,
	UdimoModule_pb.GETUDIMOINFOREPLYBACKGROUNDSFIELD,
	UdimoModule_pb.GETUDIMOINFOREPLYDECORATIONSFIELD,
	UdimoModule_pb.GETUDIMOINFOREPLYWEATHERFIELD
}
UdimoModule_pb.GETUDIMOINFOREPLY_MSG.is_extendable = false
UdimoModule_pb.GETUDIMOINFOREPLY_MSG.extensions = {}
UdimoModule_pb.USEUDIMOREQUESTUSEUDIMOIDSFIELD.name = "useUdimoIds"
UdimoModule_pb.USEUDIMOREQUESTUSEUDIMOIDSFIELD.full_name = ".UseUdimoRequest.useUdimoIds"
UdimoModule_pb.USEUDIMOREQUESTUSEUDIMOIDSFIELD.number = 1
UdimoModule_pb.USEUDIMOREQUESTUSEUDIMOIDSFIELD.index = 0
UdimoModule_pb.USEUDIMOREQUESTUSEUDIMOIDSFIELD.label = 3
UdimoModule_pb.USEUDIMOREQUESTUSEUDIMOIDSFIELD.has_default_value = false
UdimoModule_pb.USEUDIMOREQUESTUSEUDIMOIDSFIELD.default_value = {}
UdimoModule_pb.USEUDIMOREQUESTUSEUDIMOIDSFIELD.type = 5
UdimoModule_pb.USEUDIMOREQUESTUSEUDIMOIDSFIELD.cpp_type = 1
UdimoModule_pb.USEUDIMOREQUEST_MSG.name = "UseUdimoRequest"
UdimoModule_pb.USEUDIMOREQUEST_MSG.full_name = ".UseUdimoRequest"
UdimoModule_pb.USEUDIMOREQUEST_MSG.nested_types = {}
UdimoModule_pb.USEUDIMOREQUEST_MSG.enum_types = {}
UdimoModule_pb.USEUDIMOREQUEST_MSG.fields = {
	UdimoModule_pb.USEUDIMOREQUESTUSEUDIMOIDSFIELD
}
UdimoModule_pb.USEUDIMOREQUEST_MSG.is_extendable = false
UdimoModule_pb.USEUDIMOREQUEST_MSG.extensions = {}
UdimoModule_pb.USEBACKGROUNDREPLYUSEBACKGROUNDIDFIELD.name = "useBackgroundId"
UdimoModule_pb.USEBACKGROUNDREPLYUSEBACKGROUNDIDFIELD.full_name = ".UseBackgroundReply.useBackgroundId"
UdimoModule_pb.USEBACKGROUNDREPLYUSEBACKGROUNDIDFIELD.number = 1
UdimoModule_pb.USEBACKGROUNDREPLYUSEBACKGROUNDIDFIELD.index = 0
UdimoModule_pb.USEBACKGROUNDREPLYUSEBACKGROUNDIDFIELD.label = 1
UdimoModule_pb.USEBACKGROUNDREPLYUSEBACKGROUNDIDFIELD.has_default_value = false
UdimoModule_pb.USEBACKGROUNDREPLYUSEBACKGROUNDIDFIELD.default_value = 0
UdimoModule_pb.USEBACKGROUNDREPLYUSEBACKGROUNDIDFIELD.type = 5
UdimoModule_pb.USEBACKGROUNDREPLYUSEBACKGROUNDIDFIELD.cpp_type = 1
UdimoModule_pb.USEBACKGROUNDREPLY_MSG.name = "UseBackgroundReply"
UdimoModule_pb.USEBACKGROUNDREPLY_MSG.full_name = ".UseBackgroundReply"
UdimoModule_pb.USEBACKGROUNDREPLY_MSG.nested_types = {}
UdimoModule_pb.USEBACKGROUNDREPLY_MSG.enum_types = {}
UdimoModule_pb.USEBACKGROUNDREPLY_MSG.fields = {
	UdimoModule_pb.USEBACKGROUNDREPLYUSEBACKGROUNDIDFIELD
}
UdimoModule_pb.USEBACKGROUNDREPLY_MSG.is_extendable = false
UdimoModule_pb.USEBACKGROUNDREPLY_MSG.extensions = {}
UdimoModule_pb.GETUDIMOINFOREQUESTLATFIELD.name = "lat"
UdimoModule_pb.GETUDIMOINFOREQUESTLATFIELD.full_name = ".GetUdimoInfoRequest.lat"
UdimoModule_pb.GETUDIMOINFOREQUESTLATFIELD.number = 1
UdimoModule_pb.GETUDIMOINFOREQUESTLATFIELD.index = 0
UdimoModule_pb.GETUDIMOINFOREQUESTLATFIELD.label = 1
UdimoModule_pb.GETUDIMOINFOREQUESTLATFIELD.has_default_value = false
UdimoModule_pb.GETUDIMOINFOREQUESTLATFIELD.default_value = ""
UdimoModule_pb.GETUDIMOINFOREQUESTLATFIELD.type = 9
UdimoModule_pb.GETUDIMOINFOREQUESTLATFIELD.cpp_type = 9
UdimoModule_pb.GETUDIMOINFOREQUESTLONFIELD.name = "lon"
UdimoModule_pb.GETUDIMOINFOREQUESTLONFIELD.full_name = ".GetUdimoInfoRequest.lon"
UdimoModule_pb.GETUDIMOINFOREQUESTLONFIELD.number = 2
UdimoModule_pb.GETUDIMOINFOREQUESTLONFIELD.index = 1
UdimoModule_pb.GETUDIMOINFOREQUESTLONFIELD.label = 1
UdimoModule_pb.GETUDIMOINFOREQUESTLONFIELD.has_default_value = false
UdimoModule_pb.GETUDIMOINFOREQUESTLONFIELD.default_value = ""
UdimoModule_pb.GETUDIMOINFOREQUESTLONFIELD.type = 9
UdimoModule_pb.GETUDIMOINFOREQUESTLONFIELD.cpp_type = 9
UdimoModule_pb.GETUDIMOINFOREQUEST_MSG.name = "GetUdimoInfoRequest"
UdimoModule_pb.GETUDIMOINFOREQUEST_MSG.full_name = ".GetUdimoInfoRequest"
UdimoModule_pb.GETUDIMOINFOREQUEST_MSG.nested_types = {}
UdimoModule_pb.GETUDIMOINFOREQUEST_MSG.enum_types = {}
UdimoModule_pb.GETUDIMOINFOREQUEST_MSG.fields = {
	UdimoModule_pb.GETUDIMOINFOREQUESTLATFIELD,
	UdimoModule_pb.GETUDIMOINFOREQUESTLONFIELD
}
UdimoModule_pb.GETUDIMOINFOREQUEST_MSG.is_extendable = false
UdimoModule_pb.GETUDIMOINFOREQUEST_MSG.extensions = {}
UdimoModule_pb.USEUDIMOREPLYUSEUDIMOIDSFIELD.name = "useUdimoIds"
UdimoModule_pb.USEUDIMOREPLYUSEUDIMOIDSFIELD.full_name = ".UseUdimoReply.useUdimoIds"
UdimoModule_pb.USEUDIMOREPLYUSEUDIMOIDSFIELD.number = 1
UdimoModule_pb.USEUDIMOREPLYUSEUDIMOIDSFIELD.index = 0
UdimoModule_pb.USEUDIMOREPLYUSEUDIMOIDSFIELD.label = 3
UdimoModule_pb.USEUDIMOREPLYUSEUDIMOIDSFIELD.has_default_value = false
UdimoModule_pb.USEUDIMOREPLYUSEUDIMOIDSFIELD.default_value = {}
UdimoModule_pb.USEUDIMOREPLYUSEUDIMOIDSFIELD.type = 5
UdimoModule_pb.USEUDIMOREPLYUSEUDIMOIDSFIELD.cpp_type = 1
UdimoModule_pb.USEUDIMOREPLY_MSG.name = "UseUdimoReply"
UdimoModule_pb.USEUDIMOREPLY_MSG.full_name = ".UseUdimoReply"
UdimoModule_pb.USEUDIMOREPLY_MSG.nested_types = {}
UdimoModule_pb.USEUDIMOREPLY_MSG.enum_types = {}
UdimoModule_pb.USEUDIMOREPLY_MSG.fields = {
	UdimoModule_pb.USEUDIMOREPLYUSEUDIMOIDSFIELD
}
UdimoModule_pb.USEUDIMOREPLY_MSG.is_extendable = false
UdimoModule_pb.USEUDIMOREPLY_MSG.extensions = {}
UdimoModule_pb.USEDECORATIONREPLYUSEDECORATIONIDFIELD.name = "useDecorationId"
UdimoModule_pb.USEDECORATIONREPLYUSEDECORATIONIDFIELD.full_name = ".UseDecorationReply.useDecorationId"
UdimoModule_pb.USEDECORATIONREPLYUSEDECORATIONIDFIELD.number = 1
UdimoModule_pb.USEDECORATIONREPLYUSEDECORATIONIDFIELD.index = 0
UdimoModule_pb.USEDECORATIONREPLYUSEDECORATIONIDFIELD.label = 1
UdimoModule_pb.USEDECORATIONREPLYUSEDECORATIONIDFIELD.has_default_value = false
UdimoModule_pb.USEDECORATIONREPLYUSEDECORATIONIDFIELD.default_value = 0
UdimoModule_pb.USEDECORATIONREPLYUSEDECORATIONIDFIELD.type = 5
UdimoModule_pb.USEDECORATIONREPLYUSEDECORATIONIDFIELD.cpp_type = 1
UdimoModule_pb.USEDECORATIONREPLYREMOVEDECORATIONIDFIELD.name = "removeDecorationId"
UdimoModule_pb.USEDECORATIONREPLYREMOVEDECORATIONIDFIELD.full_name = ".UseDecorationReply.removeDecorationId"
UdimoModule_pb.USEDECORATIONREPLYREMOVEDECORATIONIDFIELD.number = 2
UdimoModule_pb.USEDECORATIONREPLYREMOVEDECORATIONIDFIELD.index = 1
UdimoModule_pb.USEDECORATIONREPLYREMOVEDECORATIONIDFIELD.label = 1
UdimoModule_pb.USEDECORATIONREPLYREMOVEDECORATIONIDFIELD.has_default_value = false
UdimoModule_pb.USEDECORATIONREPLYREMOVEDECORATIONIDFIELD.default_value = 0
UdimoModule_pb.USEDECORATIONREPLYREMOVEDECORATIONIDFIELD.type = 5
UdimoModule_pb.USEDECORATIONREPLYREMOVEDECORATIONIDFIELD.cpp_type = 1
UdimoModule_pb.USEDECORATIONREPLY_MSG.name = "UseDecorationReply"
UdimoModule_pb.USEDECORATIONREPLY_MSG.full_name = ".UseDecorationReply"
UdimoModule_pb.USEDECORATIONREPLY_MSG.nested_types = {}
UdimoModule_pb.USEDECORATIONREPLY_MSG.enum_types = {}
UdimoModule_pb.USEDECORATIONREPLY_MSG.fields = {
	UdimoModule_pb.USEDECORATIONREPLYUSEDECORATIONIDFIELD,
	UdimoModule_pb.USEDECORATIONREPLYREMOVEDECORATIONIDFIELD
}
UdimoModule_pb.USEDECORATIONREPLY_MSG.is_extendable = false
UdimoModule_pb.USEDECORATIONREPLY_MSG.extensions = {}
UdimoModule_pb.USEDECORATIONREQUESTUSEDECORATIONIDFIELD.name = "useDecorationId"
UdimoModule_pb.USEDECORATIONREQUESTUSEDECORATIONIDFIELD.full_name = ".UseDecorationRequest.useDecorationId"
UdimoModule_pb.USEDECORATIONREQUESTUSEDECORATIONIDFIELD.number = 1
UdimoModule_pb.USEDECORATIONREQUESTUSEDECORATIONIDFIELD.index = 0
UdimoModule_pb.USEDECORATIONREQUESTUSEDECORATIONIDFIELD.label = 1
UdimoModule_pb.USEDECORATIONREQUESTUSEDECORATIONIDFIELD.has_default_value = false
UdimoModule_pb.USEDECORATIONREQUESTUSEDECORATIONIDFIELD.default_value = 0
UdimoModule_pb.USEDECORATIONREQUESTUSEDECORATIONIDFIELD.type = 5
UdimoModule_pb.USEDECORATIONREQUESTUSEDECORATIONIDFIELD.cpp_type = 1
UdimoModule_pb.USEDECORATIONREQUESTREMOVEDECORATIONIDFIELD.name = "removeDecorationId"
UdimoModule_pb.USEDECORATIONREQUESTREMOVEDECORATIONIDFIELD.full_name = ".UseDecorationRequest.removeDecorationId"
UdimoModule_pb.USEDECORATIONREQUESTREMOVEDECORATIONIDFIELD.number = 2
UdimoModule_pb.USEDECORATIONREQUESTREMOVEDECORATIONIDFIELD.index = 1
UdimoModule_pb.USEDECORATIONREQUESTREMOVEDECORATIONIDFIELD.label = 1
UdimoModule_pb.USEDECORATIONREQUESTREMOVEDECORATIONIDFIELD.has_default_value = false
UdimoModule_pb.USEDECORATIONREQUESTREMOVEDECORATIONIDFIELD.default_value = 0
UdimoModule_pb.USEDECORATIONREQUESTREMOVEDECORATIONIDFIELD.type = 5
UdimoModule_pb.USEDECORATIONREQUESTREMOVEDECORATIONIDFIELD.cpp_type = 1
UdimoModule_pb.USEDECORATIONREQUEST_MSG.name = "UseDecorationRequest"
UdimoModule_pb.USEDECORATIONREQUEST_MSG.full_name = ".UseDecorationRequest"
UdimoModule_pb.USEDECORATIONREQUEST_MSG.nested_types = {}
UdimoModule_pb.USEDECORATIONREQUEST_MSG.enum_types = {}
UdimoModule_pb.USEDECORATIONREQUEST_MSG.fields = {
	UdimoModule_pb.USEDECORATIONREQUESTUSEDECORATIONIDFIELD,
	UdimoModule_pb.USEDECORATIONREQUESTREMOVEDECORATIONIDFIELD
}
UdimoModule_pb.USEDECORATIONREQUEST_MSG.is_extendable = false
UdimoModule_pb.USEDECORATIONREQUEST_MSG.extensions = {}
UdimoModule_pb.USEBACKGROUNDREQUESTUSEBACKGROUNDIDFIELD.name = "useBackgroundId"
UdimoModule_pb.USEBACKGROUNDREQUESTUSEBACKGROUNDIDFIELD.full_name = ".UseBackgroundRequest.useBackgroundId"
UdimoModule_pb.USEBACKGROUNDREQUESTUSEBACKGROUNDIDFIELD.number = 1
UdimoModule_pb.USEBACKGROUNDREQUESTUSEBACKGROUNDIDFIELD.index = 0
UdimoModule_pb.USEBACKGROUNDREQUESTUSEBACKGROUNDIDFIELD.label = 1
UdimoModule_pb.USEBACKGROUNDREQUESTUSEBACKGROUNDIDFIELD.has_default_value = false
UdimoModule_pb.USEBACKGROUNDREQUESTUSEBACKGROUNDIDFIELD.default_value = 0
UdimoModule_pb.USEBACKGROUNDREQUESTUSEBACKGROUNDIDFIELD.type = 5
UdimoModule_pb.USEBACKGROUNDREQUESTUSEBACKGROUNDIDFIELD.cpp_type = 1
UdimoModule_pb.USEBACKGROUNDREQUEST_MSG.name = "UseBackgroundRequest"
UdimoModule_pb.USEBACKGROUNDREQUEST_MSG.full_name = ".UseBackgroundRequest"
UdimoModule_pb.USEBACKGROUNDREQUEST_MSG.nested_types = {}
UdimoModule_pb.USEBACKGROUNDREQUEST_MSG.enum_types = {}
UdimoModule_pb.USEBACKGROUNDREQUEST_MSG.fields = {
	UdimoModule_pb.USEBACKGROUNDREQUESTUSEBACKGROUNDIDFIELD
}
UdimoModule_pb.USEBACKGROUNDREQUEST_MSG.is_extendable = false
UdimoModule_pb.USEBACKGROUNDREQUEST_MSG.extensions = {}
UdimoModule_pb.GetUdimoInfoReply = protobuf.Message(UdimoModule_pb.GETUDIMOINFOREPLY_MSG)
UdimoModule_pb.GetUdimoInfoRequest = protobuf.Message(UdimoModule_pb.GETUDIMOINFOREQUEST_MSG)
UdimoModule_pb.UdimoBackgroundNO = protobuf.Message(UdimoModule_pb.UDIMOBACKGROUNDNO_MSG)
UdimoModule_pb.UdimoDecorationNO = protobuf.Message(UdimoModule_pb.UDIMODECORATIONNO_MSG)
UdimoModule_pb.UdimoNO = protobuf.Message(UdimoModule_pb.UDIMONO_MSG)
UdimoModule_pb.UseBackgroundReply = protobuf.Message(UdimoModule_pb.USEBACKGROUNDREPLY_MSG)
UdimoModule_pb.UseBackgroundRequest = protobuf.Message(UdimoModule_pb.USEBACKGROUNDREQUEST_MSG)
UdimoModule_pb.UseDecorationReply = protobuf.Message(UdimoModule_pb.USEDECORATIONREPLY_MSG)
UdimoModule_pb.UseDecorationRequest = protobuf.Message(UdimoModule_pb.USEDECORATIONREQUEST_MSG)
UdimoModule_pb.UseUdimoReply = protobuf.Message(UdimoModule_pb.USEUDIMOREPLY_MSG)
UdimoModule_pb.UseUdimoRequest = protobuf.Message(UdimoModule_pb.USEUDIMOREQUEST_MSG)
UdimoModule_pb.WeathInfoPush = protobuf.Message(UdimoModule_pb.WEATHINFOPUSH_MSG)
UdimoModule_pb.WeatherNO = protobuf.Message(UdimoModule_pb.WEATHERNO_MSG)

return UdimoModule_pb
