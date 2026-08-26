-- chunkname: @modules/proto/GMModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.GMModule_pb", package.seeall)

local GMModule_pb = {}

GMModule_pb.GMSUMMONRESULTPUSH_MSG = protobuf.Descriptor()
GMModule_pb.GMSUMMONRESULTPUSHPOOLIDFIELD = protobuf.FieldDescriptor()
GMModule_pb.GMSUMMONRESULTPUSHTOTALCOUNTFIELD = protobuf.FieldDescriptor()
GMModule_pb.GMSUMMONRESULTPUSHSTAR6TOTALCOUNTFIELD = protobuf.FieldDescriptor()
GMModule_pb.GMSUMMONRESULTPUSHSTAR5TOTALCOUNTFIELD = protobuf.FieldDescriptor()
GMModule_pb.GMSUMMONRESULTPUSHRESJS1FIELD = protobuf.FieldDescriptor()
GMModule_pb.GMSUMMONRESULTPUSHRESJS2FIELD = protobuf.FieldDescriptor()
GMModule_pb.GMSUMMONRESULTPUSHRESJS3FIELD = protobuf.FieldDescriptor()
GMModule_pb.GMMODULEREQUEST_MSG = protobuf.Descriptor()
GMModule_pb.SERVERERRORINFOPUSH_MSG = protobuf.Descriptor()
GMModule_pb.SERVERERRORINFOPUSHMSGFIELD = protobuf.FieldDescriptor()
GMModule_pb.SERVERERRORINFOPUSHISALERTFIELD = protobuf.FieldDescriptor()
GMModule_pb.GPUCPULOGREPLY_MSG = protobuf.Descriptor()
GMModule_pb.GPUCPULOGREQUEST_MSG = protobuf.Descriptor()
GMModule_pb.GPUCPULOGREQUESTGPUFIELD = protobuf.FieldDescriptor()
GMModule_pb.GPUCPULOGREQUESTCPUFIELD = protobuf.FieldDescriptor()
GMModule_pb.GMREQUEST_MSG = protobuf.Descriptor()
GMModule_pb.GMREQUESTCOMMANDTEXTFIELD = protobuf.FieldDescriptor()
GMModule_pb.GMREPLY_MSG = protobuf.Descriptor()
GMModule_pb.GMREPLYRESULTENUM = protobuf.EnumDescriptor()
GMModule_pb.GMREPLYRESULTENUMOKENUM = protobuf.EnumValueDescriptor()
GMModule_pb.GMREPLYRESULTENUMFAILEDENUM = protobuf.EnumValueDescriptor()
GMModule_pb.GMREPLYRESULTENUMUNKNOWN_CMDENUM = protobuf.EnumValueDescriptor()
GMModule_pb.GMREPLYRESULTFIELD = protobuf.FieldDescriptor()
GMModule_pb.GMMODULEREPLY_MSG = protobuf.Descriptor()
GMModule_pb.GMMODULEREPLYMODULESFIELD = protobuf.FieldDescriptor()
GMModule_pb.GMMODULE_MSG = protobuf.Descriptor()
GMModule_pb.GMMODULENAMEFIELD = protobuf.FieldDescriptor()
GMModule_pb.GMMODULECMDSFIELD = protobuf.FieldDescriptor()
GMModule_pb.GMMODULEORDERFIELD = protobuf.FieldDescriptor()
GMModule_pb.FIGHTTIPSMESSAGEPUSH_MSG = protobuf.Descriptor()
GMModule_pb.FIGHTTIPSMESSAGEPUSHMSGFIELD = protobuf.FieldDescriptor()
GMModule_pb.GMCOMMAND_MSG = protobuf.Descriptor()
GMModule_pb.GMCOMMANDNAMEFIELD = protobuf.FieldDescriptor()
GMModule_pb.GMCOMMANDDESCFIELD = protobuf.FieldDescriptor()
GMModule_pb.GMCOMMANDPARAMSFIELD = protobuf.FieldDescriptor()
GMModule_pb.GMCOMMANDORDERFIELD = protobuf.FieldDescriptor()
GMModule_pb.TESTGMTEXTREPLY_MSG = protobuf.Descriptor()
GMModule_pb.TESTGMTEXTREPLYTEXTFIELD = protobuf.FieldDescriptor()
GMModule_pb.GMCOMMANDPARAM_MSG = protobuf.Descriptor()
GMModule_pb.GMCOMMANDPARAMDESCFIELD = protobuf.FieldDescriptor()
GMModule_pb.GMSUMMONRESULTPUSHPOOLIDFIELD.name = "poolId"
GMModule_pb.GMSUMMONRESULTPUSHPOOLIDFIELD.full_name = ".GMSummonResultPush.poolId"
GMModule_pb.GMSUMMONRESULTPUSHPOOLIDFIELD.number = 1
GMModule_pb.GMSUMMONRESULTPUSHPOOLIDFIELD.index = 0
GMModule_pb.GMSUMMONRESULTPUSHPOOLIDFIELD.label = 1
GMModule_pb.GMSUMMONRESULTPUSHPOOLIDFIELD.has_default_value = false
GMModule_pb.GMSUMMONRESULTPUSHPOOLIDFIELD.default_value = 0
GMModule_pb.GMSUMMONRESULTPUSHPOOLIDFIELD.type = 5
GMModule_pb.GMSUMMONRESULTPUSHPOOLIDFIELD.cpp_type = 1
GMModule_pb.GMSUMMONRESULTPUSHTOTALCOUNTFIELD.name = "totalCount"
GMModule_pb.GMSUMMONRESULTPUSHTOTALCOUNTFIELD.full_name = ".GMSummonResultPush.totalCount"
GMModule_pb.GMSUMMONRESULTPUSHTOTALCOUNTFIELD.number = 2
GMModule_pb.GMSUMMONRESULTPUSHTOTALCOUNTFIELD.index = 1
GMModule_pb.GMSUMMONRESULTPUSHTOTALCOUNTFIELD.label = 1
GMModule_pb.GMSUMMONRESULTPUSHTOTALCOUNTFIELD.has_default_value = false
GMModule_pb.GMSUMMONRESULTPUSHTOTALCOUNTFIELD.default_value = 0
GMModule_pb.GMSUMMONRESULTPUSHTOTALCOUNTFIELD.type = 5
GMModule_pb.GMSUMMONRESULTPUSHTOTALCOUNTFIELD.cpp_type = 1
GMModule_pb.GMSUMMONRESULTPUSHSTAR6TOTALCOUNTFIELD.name = "star6TotalCount"
GMModule_pb.GMSUMMONRESULTPUSHSTAR6TOTALCOUNTFIELD.full_name = ".GMSummonResultPush.star6TotalCount"
GMModule_pb.GMSUMMONRESULTPUSHSTAR6TOTALCOUNTFIELD.number = 3
GMModule_pb.GMSUMMONRESULTPUSHSTAR6TOTALCOUNTFIELD.index = 2
GMModule_pb.GMSUMMONRESULTPUSHSTAR6TOTALCOUNTFIELD.label = 1
GMModule_pb.GMSUMMONRESULTPUSHSTAR6TOTALCOUNTFIELD.has_default_value = false
GMModule_pb.GMSUMMONRESULTPUSHSTAR6TOTALCOUNTFIELD.default_value = 0
GMModule_pb.GMSUMMONRESULTPUSHSTAR6TOTALCOUNTFIELD.type = 5
GMModule_pb.GMSUMMONRESULTPUSHSTAR6TOTALCOUNTFIELD.cpp_type = 1
GMModule_pb.GMSUMMONRESULTPUSHSTAR5TOTALCOUNTFIELD.name = "star5TotalCount"
GMModule_pb.GMSUMMONRESULTPUSHSTAR5TOTALCOUNTFIELD.full_name = ".GMSummonResultPush.star5TotalCount"
GMModule_pb.GMSUMMONRESULTPUSHSTAR5TOTALCOUNTFIELD.number = 4
GMModule_pb.GMSUMMONRESULTPUSHSTAR5TOTALCOUNTFIELD.index = 3
GMModule_pb.GMSUMMONRESULTPUSHSTAR5TOTALCOUNTFIELD.label = 1
GMModule_pb.GMSUMMONRESULTPUSHSTAR5TOTALCOUNTFIELD.has_default_value = false
GMModule_pb.GMSUMMONRESULTPUSHSTAR5TOTALCOUNTFIELD.default_value = 0
GMModule_pb.GMSUMMONRESULTPUSHSTAR5TOTALCOUNTFIELD.type = 5
GMModule_pb.GMSUMMONRESULTPUSHSTAR5TOTALCOUNTFIELD.cpp_type = 1
GMModule_pb.GMSUMMONRESULTPUSHRESJS1FIELD.name = "resJs1"
GMModule_pb.GMSUMMONRESULTPUSHRESJS1FIELD.full_name = ".GMSummonResultPush.resJs1"
GMModule_pb.GMSUMMONRESULTPUSHRESJS1FIELD.number = 5
GMModule_pb.GMSUMMONRESULTPUSHRESJS1FIELD.index = 4
GMModule_pb.GMSUMMONRESULTPUSHRESJS1FIELD.label = 1
GMModule_pb.GMSUMMONRESULTPUSHRESJS1FIELD.has_default_value = false
GMModule_pb.GMSUMMONRESULTPUSHRESJS1FIELD.default_value = ""
GMModule_pb.GMSUMMONRESULTPUSHRESJS1FIELD.type = 9
GMModule_pb.GMSUMMONRESULTPUSHRESJS1FIELD.cpp_type = 9
GMModule_pb.GMSUMMONRESULTPUSHRESJS2FIELD.name = "resJs2"
GMModule_pb.GMSUMMONRESULTPUSHRESJS2FIELD.full_name = ".GMSummonResultPush.resJs2"
GMModule_pb.GMSUMMONRESULTPUSHRESJS2FIELD.number = 6
GMModule_pb.GMSUMMONRESULTPUSHRESJS2FIELD.index = 5
GMModule_pb.GMSUMMONRESULTPUSHRESJS2FIELD.label = 1
GMModule_pb.GMSUMMONRESULTPUSHRESJS2FIELD.has_default_value = false
GMModule_pb.GMSUMMONRESULTPUSHRESJS2FIELD.default_value = ""
GMModule_pb.GMSUMMONRESULTPUSHRESJS2FIELD.type = 9
GMModule_pb.GMSUMMONRESULTPUSHRESJS2FIELD.cpp_type = 9
GMModule_pb.GMSUMMONRESULTPUSHRESJS3FIELD.name = "resJs3"
GMModule_pb.GMSUMMONRESULTPUSHRESJS3FIELD.full_name = ".GMSummonResultPush.resJs3"
GMModule_pb.GMSUMMONRESULTPUSHRESJS3FIELD.number = 7
GMModule_pb.GMSUMMONRESULTPUSHRESJS3FIELD.index = 6
GMModule_pb.GMSUMMONRESULTPUSHRESJS3FIELD.label = 1
GMModule_pb.GMSUMMONRESULTPUSHRESJS3FIELD.has_default_value = false
GMModule_pb.GMSUMMONRESULTPUSHRESJS3FIELD.default_value = ""
GMModule_pb.GMSUMMONRESULTPUSHRESJS3FIELD.type = 9
GMModule_pb.GMSUMMONRESULTPUSHRESJS3FIELD.cpp_type = 9
GMModule_pb.GMSUMMONRESULTPUSH_MSG.name = "GMSummonResultPush"
GMModule_pb.GMSUMMONRESULTPUSH_MSG.full_name = ".GMSummonResultPush"
GMModule_pb.GMSUMMONRESULTPUSH_MSG.nested_types = {}
GMModule_pb.GMSUMMONRESULTPUSH_MSG.enum_types = {}
GMModule_pb.GMSUMMONRESULTPUSH_MSG.fields = {
	GMModule_pb.GMSUMMONRESULTPUSHPOOLIDFIELD,
	GMModule_pb.GMSUMMONRESULTPUSHTOTALCOUNTFIELD,
	GMModule_pb.GMSUMMONRESULTPUSHSTAR6TOTALCOUNTFIELD,
	GMModule_pb.GMSUMMONRESULTPUSHSTAR5TOTALCOUNTFIELD,
	GMModule_pb.GMSUMMONRESULTPUSHRESJS1FIELD,
	GMModule_pb.GMSUMMONRESULTPUSHRESJS2FIELD,
	GMModule_pb.GMSUMMONRESULTPUSHRESJS3FIELD
}
GMModule_pb.GMSUMMONRESULTPUSH_MSG.is_extendable = false
GMModule_pb.GMSUMMONRESULTPUSH_MSG.extensions = {}
GMModule_pb.GMMODULEREQUEST_MSG.name = "GmModuleRequest"
GMModule_pb.GMMODULEREQUEST_MSG.full_name = ".GmModuleRequest"
GMModule_pb.GMMODULEREQUEST_MSG.nested_types = {}
GMModule_pb.GMMODULEREQUEST_MSG.enum_types = {}
GMModule_pb.GMMODULEREQUEST_MSG.fields = {}
GMModule_pb.GMMODULEREQUEST_MSG.is_extendable = false
GMModule_pb.GMMODULEREQUEST_MSG.extensions = {}
GMModule_pb.SERVERERRORINFOPUSHMSGFIELD.name = "msg"
GMModule_pb.SERVERERRORINFOPUSHMSGFIELD.full_name = ".ServerErrorInfoPush.msg"
GMModule_pb.SERVERERRORINFOPUSHMSGFIELD.number = 1
GMModule_pb.SERVERERRORINFOPUSHMSGFIELD.index = 0
GMModule_pb.SERVERERRORINFOPUSHMSGFIELD.label = 1
GMModule_pb.SERVERERRORINFOPUSHMSGFIELD.has_default_value = false
GMModule_pb.SERVERERRORINFOPUSHMSGFIELD.default_value = ""
GMModule_pb.SERVERERRORINFOPUSHMSGFIELD.type = 9
GMModule_pb.SERVERERRORINFOPUSHMSGFIELD.cpp_type = 9
GMModule_pb.SERVERERRORINFOPUSHISALERTFIELD.name = "isAlert"
GMModule_pb.SERVERERRORINFOPUSHISALERTFIELD.full_name = ".ServerErrorInfoPush.isAlert"
GMModule_pb.SERVERERRORINFOPUSHISALERTFIELD.number = 2
GMModule_pb.SERVERERRORINFOPUSHISALERTFIELD.index = 1
GMModule_pb.SERVERERRORINFOPUSHISALERTFIELD.label = 1
GMModule_pb.SERVERERRORINFOPUSHISALERTFIELD.has_default_value = false
GMModule_pb.SERVERERRORINFOPUSHISALERTFIELD.default_value = false
GMModule_pb.SERVERERRORINFOPUSHISALERTFIELD.type = 8
GMModule_pb.SERVERERRORINFOPUSHISALERTFIELD.cpp_type = 7
GMModule_pb.SERVERERRORINFOPUSH_MSG.name = "ServerErrorInfoPush"
GMModule_pb.SERVERERRORINFOPUSH_MSG.full_name = ".ServerErrorInfoPush"
GMModule_pb.SERVERERRORINFOPUSH_MSG.nested_types = {}
GMModule_pb.SERVERERRORINFOPUSH_MSG.enum_types = {}
GMModule_pb.SERVERERRORINFOPUSH_MSG.fields = {
	GMModule_pb.SERVERERRORINFOPUSHMSGFIELD,
	GMModule_pb.SERVERERRORINFOPUSHISALERTFIELD
}
GMModule_pb.SERVERERRORINFOPUSH_MSG.is_extendable = false
GMModule_pb.SERVERERRORINFOPUSH_MSG.extensions = {}
GMModule_pb.GPUCPULOGREPLY_MSG.name = "GpuCpuLogReply"
GMModule_pb.GPUCPULOGREPLY_MSG.full_name = ".GpuCpuLogReply"
GMModule_pb.GPUCPULOGREPLY_MSG.nested_types = {}
GMModule_pb.GPUCPULOGREPLY_MSG.enum_types = {}
GMModule_pb.GPUCPULOGREPLY_MSG.fields = {}
GMModule_pb.GPUCPULOGREPLY_MSG.is_extendable = false
GMModule_pb.GPUCPULOGREPLY_MSG.extensions = {}
GMModule_pb.GPUCPULOGREQUESTGPUFIELD.name = "gpu"
GMModule_pb.GPUCPULOGREQUESTGPUFIELD.full_name = ".GpuCpuLogRequest.gpu"
GMModule_pb.GPUCPULOGREQUESTGPUFIELD.number = 1
GMModule_pb.GPUCPULOGREQUESTGPUFIELD.index = 0
GMModule_pb.GPUCPULOGREQUESTGPUFIELD.label = 1
GMModule_pb.GPUCPULOGREQUESTGPUFIELD.has_default_value = false
GMModule_pb.GPUCPULOGREQUESTGPUFIELD.default_value = ""
GMModule_pb.GPUCPULOGREQUESTGPUFIELD.type = 9
GMModule_pb.GPUCPULOGREQUESTGPUFIELD.cpp_type = 9
GMModule_pb.GPUCPULOGREQUESTCPUFIELD.name = "cpu"
GMModule_pb.GPUCPULOGREQUESTCPUFIELD.full_name = ".GpuCpuLogRequest.cpu"
GMModule_pb.GPUCPULOGREQUESTCPUFIELD.number = 2
GMModule_pb.GPUCPULOGREQUESTCPUFIELD.index = 1
GMModule_pb.GPUCPULOGREQUESTCPUFIELD.label = 1
GMModule_pb.GPUCPULOGREQUESTCPUFIELD.has_default_value = false
GMModule_pb.GPUCPULOGREQUESTCPUFIELD.default_value = ""
GMModule_pb.GPUCPULOGREQUESTCPUFIELD.type = 9
GMModule_pb.GPUCPULOGREQUESTCPUFIELD.cpp_type = 9
GMModule_pb.GPUCPULOGREQUEST_MSG.name = "GpuCpuLogRequest"
GMModule_pb.GPUCPULOGREQUEST_MSG.full_name = ".GpuCpuLogRequest"
GMModule_pb.GPUCPULOGREQUEST_MSG.nested_types = {}
GMModule_pb.GPUCPULOGREQUEST_MSG.enum_types = {}
GMModule_pb.GPUCPULOGREQUEST_MSG.fields = {
	GMModule_pb.GPUCPULOGREQUESTGPUFIELD,
	GMModule_pb.GPUCPULOGREQUESTCPUFIELD
}
GMModule_pb.GPUCPULOGREQUEST_MSG.is_extendable = false
GMModule_pb.GPUCPULOGREQUEST_MSG.extensions = {}
GMModule_pb.GMREQUESTCOMMANDTEXTFIELD.name = "commandText"
GMModule_pb.GMREQUESTCOMMANDTEXTFIELD.full_name = ".GMRequest.commandText"
GMModule_pb.GMREQUESTCOMMANDTEXTFIELD.number = 1
GMModule_pb.GMREQUESTCOMMANDTEXTFIELD.index = 0
GMModule_pb.GMREQUESTCOMMANDTEXTFIELD.label = 2
GMModule_pb.GMREQUESTCOMMANDTEXTFIELD.has_default_value = false
GMModule_pb.GMREQUESTCOMMANDTEXTFIELD.default_value = ""
GMModule_pb.GMREQUESTCOMMANDTEXTFIELD.type = 9
GMModule_pb.GMREQUESTCOMMANDTEXTFIELD.cpp_type = 9
GMModule_pb.GMREQUEST_MSG.name = "GMRequest"
GMModule_pb.GMREQUEST_MSG.full_name = ".GMRequest"
GMModule_pb.GMREQUEST_MSG.nested_types = {}
GMModule_pb.GMREQUEST_MSG.enum_types = {}
GMModule_pb.GMREQUEST_MSG.fields = {
	GMModule_pb.GMREQUESTCOMMANDTEXTFIELD
}
GMModule_pb.GMREQUEST_MSG.is_extendable = false
GMModule_pb.GMREQUEST_MSG.extensions = {}
GMModule_pb.GMREPLYRESULTENUMOKENUM.name = "OK"
GMModule_pb.GMREPLYRESULTENUMOKENUM.index = 0
GMModule_pb.GMREPLYRESULTENUMOKENUM.number = 0
GMModule_pb.GMREPLYRESULTENUMFAILEDENUM.name = "FAILED"
GMModule_pb.GMREPLYRESULTENUMFAILEDENUM.index = 1
GMModule_pb.GMREPLYRESULTENUMFAILEDENUM.number = 1
GMModule_pb.GMREPLYRESULTENUMUNKNOWN_CMDENUM.name = "UNKNOWN_CMD"
GMModule_pb.GMREPLYRESULTENUMUNKNOWN_CMDENUM.index = 2
GMModule_pb.GMREPLYRESULTENUMUNKNOWN_CMDENUM.number = 2
GMModule_pb.GMREPLYRESULTENUM.name = "ResultEnum"
GMModule_pb.GMREPLYRESULTENUM.full_name = ".GMReply.ResultEnum"
GMModule_pb.GMREPLYRESULTENUM.values = {
	GMModule_pb.GMREPLYRESULTENUMOKENUM,
	GMModule_pb.GMREPLYRESULTENUMFAILEDENUM,
	GMModule_pb.GMREPLYRESULTENUMUNKNOWN_CMDENUM
}
GMModule_pb.GMREPLYRESULTFIELD.name = "result"
GMModule_pb.GMREPLYRESULTFIELD.full_name = ".GMReply.result"
GMModule_pb.GMREPLYRESULTFIELD.number = 1
GMModule_pb.GMREPLYRESULTFIELD.index = 0
GMModule_pb.GMREPLYRESULTFIELD.label = 1
GMModule_pb.GMREPLYRESULTFIELD.has_default_value = false
GMModule_pb.GMREPLYRESULTFIELD.default_value = nil
GMModule_pb.GMREPLYRESULTFIELD.enum_type = GMModule_pb.GMREPLYRESULTENUM_ENUM
GMModule_pb.GMREPLYRESULTFIELD.type = 14
GMModule_pb.GMREPLYRESULTFIELD.cpp_type = 8
GMModule_pb.GMREPLY_MSG.name = "GMReply"
GMModule_pb.GMREPLY_MSG.full_name = ".GMReply"
GMModule_pb.GMREPLY_MSG.nested_types = {}
GMModule_pb.GMREPLY_MSG.enum_types = {
	GMModule_pb.GMREPLYRESULTENUM
}
GMModule_pb.GMREPLY_MSG.fields = {
	GMModule_pb.GMREPLYRESULTFIELD
}
GMModule_pb.GMREPLY_MSG.is_extendable = false
GMModule_pb.GMREPLY_MSG.extensions = {}
GMModule_pb.GMMODULEREPLYMODULESFIELD.name = "modules"
GMModule_pb.GMMODULEREPLYMODULESFIELD.full_name = ".GmModuleReply.modules"
GMModule_pb.GMMODULEREPLYMODULESFIELD.number = 1
GMModule_pb.GMMODULEREPLYMODULESFIELD.index = 0
GMModule_pb.GMMODULEREPLYMODULESFIELD.label = 3
GMModule_pb.GMMODULEREPLYMODULESFIELD.has_default_value = false
GMModule_pb.GMMODULEREPLYMODULESFIELD.default_value = {}
GMModule_pb.GMMODULEREPLYMODULESFIELD.message_type = GMModule_pb.GMMODULE_MSG
GMModule_pb.GMMODULEREPLYMODULESFIELD.type = 11
GMModule_pb.GMMODULEREPLYMODULESFIELD.cpp_type = 10
GMModule_pb.GMMODULEREPLY_MSG.name = "GmModuleReply"
GMModule_pb.GMMODULEREPLY_MSG.full_name = ".GmModuleReply"
GMModule_pb.GMMODULEREPLY_MSG.nested_types = {}
GMModule_pb.GMMODULEREPLY_MSG.enum_types = {}
GMModule_pb.GMMODULEREPLY_MSG.fields = {
	GMModule_pb.GMMODULEREPLYMODULESFIELD
}
GMModule_pb.GMMODULEREPLY_MSG.is_extendable = false
GMModule_pb.GMMODULEREPLY_MSG.extensions = {}
GMModule_pb.GMMODULENAMEFIELD.name = "name"
GMModule_pb.GMMODULENAMEFIELD.full_name = ".GmModule.name"
GMModule_pb.GMMODULENAMEFIELD.number = 1
GMModule_pb.GMMODULENAMEFIELD.index = 0
GMModule_pb.GMMODULENAMEFIELD.label = 1
GMModule_pb.GMMODULENAMEFIELD.has_default_value = false
GMModule_pb.GMMODULENAMEFIELD.default_value = ""
GMModule_pb.GMMODULENAMEFIELD.type = 9
GMModule_pb.GMMODULENAMEFIELD.cpp_type = 9
GMModule_pb.GMMODULECMDSFIELD.name = "cmds"
GMModule_pb.GMMODULECMDSFIELD.full_name = ".GmModule.cmds"
GMModule_pb.GMMODULECMDSFIELD.number = 2
GMModule_pb.GMMODULECMDSFIELD.index = 1
GMModule_pb.GMMODULECMDSFIELD.label = 3
GMModule_pb.GMMODULECMDSFIELD.has_default_value = false
GMModule_pb.GMMODULECMDSFIELD.default_value = {}
GMModule_pb.GMMODULECMDSFIELD.message_type = GMModule_pb.GMCOMMAND_MSG
GMModule_pb.GMMODULECMDSFIELD.type = 11
GMModule_pb.GMMODULECMDSFIELD.cpp_type = 10
GMModule_pb.GMMODULEORDERFIELD.name = "order"
GMModule_pb.GMMODULEORDERFIELD.full_name = ".GmModule.order"
GMModule_pb.GMMODULEORDERFIELD.number = 3
GMModule_pb.GMMODULEORDERFIELD.index = 2
GMModule_pb.GMMODULEORDERFIELD.label = 1
GMModule_pb.GMMODULEORDERFIELD.has_default_value = false
GMModule_pb.GMMODULEORDERFIELD.default_value = 0
GMModule_pb.GMMODULEORDERFIELD.type = 5
GMModule_pb.GMMODULEORDERFIELD.cpp_type = 1
GMModule_pb.GMMODULE_MSG.name = "GmModule"
GMModule_pb.GMMODULE_MSG.full_name = ".GmModule"
GMModule_pb.GMMODULE_MSG.nested_types = {}
GMModule_pb.GMMODULE_MSG.enum_types = {}
GMModule_pb.GMMODULE_MSG.fields = {
	GMModule_pb.GMMODULENAMEFIELD,
	GMModule_pb.GMMODULECMDSFIELD,
	GMModule_pb.GMMODULEORDERFIELD
}
GMModule_pb.GMMODULE_MSG.is_extendable = false
GMModule_pb.GMMODULE_MSG.extensions = {}
GMModule_pb.FIGHTTIPSMESSAGEPUSHMSGFIELD.name = "msg"
GMModule_pb.FIGHTTIPSMESSAGEPUSHMSGFIELD.full_name = ".FightTipsMessagePush.msg"
GMModule_pb.FIGHTTIPSMESSAGEPUSHMSGFIELD.number = 1
GMModule_pb.FIGHTTIPSMESSAGEPUSHMSGFIELD.index = 0
GMModule_pb.FIGHTTIPSMESSAGEPUSHMSGFIELD.label = 1
GMModule_pb.FIGHTTIPSMESSAGEPUSHMSGFIELD.has_default_value = false
GMModule_pb.FIGHTTIPSMESSAGEPUSHMSGFIELD.default_value = ""
GMModule_pb.FIGHTTIPSMESSAGEPUSHMSGFIELD.type = 9
GMModule_pb.FIGHTTIPSMESSAGEPUSHMSGFIELD.cpp_type = 9
GMModule_pb.FIGHTTIPSMESSAGEPUSH_MSG.name = "FightTipsMessagePush"
GMModule_pb.FIGHTTIPSMESSAGEPUSH_MSG.full_name = ".FightTipsMessagePush"
GMModule_pb.FIGHTTIPSMESSAGEPUSH_MSG.nested_types = {}
GMModule_pb.FIGHTTIPSMESSAGEPUSH_MSG.enum_types = {}
GMModule_pb.FIGHTTIPSMESSAGEPUSH_MSG.fields = {
	GMModule_pb.FIGHTTIPSMESSAGEPUSHMSGFIELD
}
GMModule_pb.FIGHTTIPSMESSAGEPUSH_MSG.is_extendable = false
GMModule_pb.FIGHTTIPSMESSAGEPUSH_MSG.extensions = {}
GMModule_pb.GMCOMMANDNAMEFIELD.name = "name"
GMModule_pb.GMCOMMANDNAMEFIELD.full_name = ".GmCommand.name"
GMModule_pb.GMCOMMANDNAMEFIELD.number = 1
GMModule_pb.GMCOMMANDNAMEFIELD.index = 0
GMModule_pb.GMCOMMANDNAMEFIELD.label = 1
GMModule_pb.GMCOMMANDNAMEFIELD.has_default_value = false
GMModule_pb.GMCOMMANDNAMEFIELD.default_value = ""
GMModule_pb.GMCOMMANDNAMEFIELD.type = 9
GMModule_pb.GMCOMMANDNAMEFIELD.cpp_type = 9
GMModule_pb.GMCOMMANDDESCFIELD.name = "desc"
GMModule_pb.GMCOMMANDDESCFIELD.full_name = ".GmCommand.desc"
GMModule_pb.GMCOMMANDDESCFIELD.number = 2
GMModule_pb.GMCOMMANDDESCFIELD.index = 1
GMModule_pb.GMCOMMANDDESCFIELD.label = 1
GMModule_pb.GMCOMMANDDESCFIELD.has_default_value = false
GMModule_pb.GMCOMMANDDESCFIELD.default_value = ""
GMModule_pb.GMCOMMANDDESCFIELD.type = 9
GMModule_pb.GMCOMMANDDESCFIELD.cpp_type = 9
GMModule_pb.GMCOMMANDPARAMSFIELD.name = "params"
GMModule_pb.GMCOMMANDPARAMSFIELD.full_name = ".GmCommand.params"
GMModule_pb.GMCOMMANDPARAMSFIELD.number = 3
GMModule_pb.GMCOMMANDPARAMSFIELD.index = 2
GMModule_pb.GMCOMMANDPARAMSFIELD.label = 3
GMModule_pb.GMCOMMANDPARAMSFIELD.has_default_value = false
GMModule_pb.GMCOMMANDPARAMSFIELD.default_value = {}
GMModule_pb.GMCOMMANDPARAMSFIELD.message_type = GMModule_pb.GMCOMMANDPARAM_MSG
GMModule_pb.GMCOMMANDPARAMSFIELD.type = 11
GMModule_pb.GMCOMMANDPARAMSFIELD.cpp_type = 10
GMModule_pb.GMCOMMANDORDERFIELD.name = "order"
GMModule_pb.GMCOMMANDORDERFIELD.full_name = ".GmCommand.order"
GMModule_pb.GMCOMMANDORDERFIELD.number = 4
GMModule_pb.GMCOMMANDORDERFIELD.index = 3
GMModule_pb.GMCOMMANDORDERFIELD.label = 1
GMModule_pb.GMCOMMANDORDERFIELD.has_default_value = false
GMModule_pb.GMCOMMANDORDERFIELD.default_value = 0
GMModule_pb.GMCOMMANDORDERFIELD.type = 5
GMModule_pb.GMCOMMANDORDERFIELD.cpp_type = 1
GMModule_pb.GMCOMMAND_MSG.name = "GmCommand"
GMModule_pb.GMCOMMAND_MSG.full_name = ".GmCommand"
GMModule_pb.GMCOMMAND_MSG.nested_types = {}
GMModule_pb.GMCOMMAND_MSG.enum_types = {}
GMModule_pb.GMCOMMAND_MSG.fields = {
	GMModule_pb.GMCOMMANDNAMEFIELD,
	GMModule_pb.GMCOMMANDDESCFIELD,
	GMModule_pb.GMCOMMANDPARAMSFIELD,
	GMModule_pb.GMCOMMANDORDERFIELD
}
GMModule_pb.GMCOMMAND_MSG.is_extendable = false
GMModule_pb.GMCOMMAND_MSG.extensions = {}
GMModule_pb.TESTGMTEXTREPLYTEXTFIELD.name = "text"
GMModule_pb.TESTGMTEXTREPLYTEXTFIELD.full_name = ".TestGMTextReply.text"
GMModule_pb.TESTGMTEXTREPLYTEXTFIELD.number = 1
GMModule_pb.TESTGMTEXTREPLYTEXTFIELD.index = 0
GMModule_pb.TESTGMTEXTREPLYTEXTFIELD.label = 1
GMModule_pb.TESTGMTEXTREPLYTEXTFIELD.has_default_value = false
GMModule_pb.TESTGMTEXTREPLYTEXTFIELD.default_value = ""
GMModule_pb.TESTGMTEXTREPLYTEXTFIELD.type = 9
GMModule_pb.TESTGMTEXTREPLYTEXTFIELD.cpp_type = 9
GMModule_pb.TESTGMTEXTREPLY_MSG.name = "TestGMTextReply"
GMModule_pb.TESTGMTEXTREPLY_MSG.full_name = ".TestGMTextReply"
GMModule_pb.TESTGMTEXTREPLY_MSG.nested_types = {}
GMModule_pb.TESTGMTEXTREPLY_MSG.enum_types = {}
GMModule_pb.TESTGMTEXTREPLY_MSG.fields = {
	GMModule_pb.TESTGMTEXTREPLYTEXTFIELD
}
GMModule_pb.TESTGMTEXTREPLY_MSG.is_extendable = false
GMModule_pb.TESTGMTEXTREPLY_MSG.extensions = {}
GMModule_pb.GMCOMMANDPARAMDESCFIELD.name = "desc"
GMModule_pb.GMCOMMANDPARAMDESCFIELD.full_name = ".GmCommandParam.desc"
GMModule_pb.GMCOMMANDPARAMDESCFIELD.number = 1
GMModule_pb.GMCOMMANDPARAMDESCFIELD.index = 0
GMModule_pb.GMCOMMANDPARAMDESCFIELD.label = 1
GMModule_pb.GMCOMMANDPARAMDESCFIELD.has_default_value = false
GMModule_pb.GMCOMMANDPARAMDESCFIELD.default_value = ""
GMModule_pb.GMCOMMANDPARAMDESCFIELD.type = 9
GMModule_pb.GMCOMMANDPARAMDESCFIELD.cpp_type = 9
GMModule_pb.GMCOMMANDPARAM_MSG.name = "GmCommandParam"
GMModule_pb.GMCOMMANDPARAM_MSG.full_name = ".GmCommandParam"
GMModule_pb.GMCOMMANDPARAM_MSG.nested_types = {}
GMModule_pb.GMCOMMANDPARAM_MSG.enum_types = {}
GMModule_pb.GMCOMMANDPARAM_MSG.fields = {
	GMModule_pb.GMCOMMANDPARAMDESCFIELD
}
GMModule_pb.GMCOMMANDPARAM_MSG.is_extendable = false
GMModule_pb.GMCOMMANDPARAM_MSG.extensions = {}
GMModule_pb.FightTipsMessagePush = protobuf.Message(GMModule_pb.FIGHTTIPSMESSAGEPUSH_MSG)
GMModule_pb.GMReply = protobuf.Message(GMModule_pb.GMREPLY_MSG)
GMModule_pb.GMRequest = protobuf.Message(GMModule_pb.GMREQUEST_MSG)
GMModule_pb.GMSummonResultPush = protobuf.Message(GMModule_pb.GMSUMMONRESULTPUSH_MSG)
GMModule_pb.GmCommand = protobuf.Message(GMModule_pb.GMCOMMAND_MSG)
GMModule_pb.GmCommandParam = protobuf.Message(GMModule_pb.GMCOMMANDPARAM_MSG)
GMModule_pb.GmModule = protobuf.Message(GMModule_pb.GMMODULE_MSG)
GMModule_pb.GmModuleReply = protobuf.Message(GMModule_pb.GMMODULEREPLY_MSG)
GMModule_pb.GmModuleRequest = protobuf.Message(GMModule_pb.GMMODULEREQUEST_MSG)
GMModule_pb.GpuCpuLogReply = protobuf.Message(GMModule_pb.GPUCPULOGREPLY_MSG)
GMModule_pb.GpuCpuLogRequest = protobuf.Message(GMModule_pb.GPUCPULOGREQUEST_MSG)
GMModule_pb.ServerErrorInfoPush = protobuf.Message(GMModule_pb.SERVERERRORINFOPUSH_MSG)
GMModule_pb.TestGMTextReply = protobuf.Message(GMModule_pb.TESTGMTEXTREPLY_MSG)

return GMModule_pb
