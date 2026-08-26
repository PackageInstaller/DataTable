-- chunkname: @modules/proto/ChatModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.ChatModule_pb", package.seeall)

local ChatModule_pb = {}

ChatModule_pb.DELETEOFFLINEMSGREPLY_MSG = protobuf.Descriptor()
ChatModule_pb.REPORTREQUEST_MSG = protobuf.Descriptor()
ChatModule_pb.REPORTREQUESTREPORTEDUSERIDFIELD = protobuf.FieldDescriptor()
ChatModule_pb.REPORTREQUESTREPORTTYPEIDFIELD = protobuf.FieldDescriptor()
ChatModule_pb.REPORTREQUESTCONTENTFIELD = protobuf.FieldDescriptor()
ChatModule_pb.SENDMSGREPLY_MSG = protobuf.Descriptor()
ChatModule_pb.SENDMSGREPLYMESSAGEFIELD = protobuf.FieldDescriptor()
ChatModule_pb.SENDMSGREPLYCONTENTFIELD = protobuf.FieldDescriptor()
ChatModule_pb.SENDMSGREPLYCHANNELTYPEFIELD = protobuf.FieldDescriptor()
ChatModule_pb.SENDMSGREPLYMSGTYPEFIELD = protobuf.FieldDescriptor()
ChatModule_pb.SENDMSGREPLYEXTDATAFIELD = protobuf.FieldDescriptor()
ChatModule_pb.SENDMSGREQUEST_MSG = protobuf.Descriptor()
ChatModule_pb.SENDMSGREQUESTCHANNELTYPEFIELD = protobuf.FieldDescriptor()
ChatModule_pb.SENDMSGREQUESTRECIPIENTIDFIELD = protobuf.FieldDescriptor()
ChatModule_pb.SENDMSGREQUESTCONTENTFIELD = protobuf.FieldDescriptor()
ChatModule_pb.SENDMSGREQUESTMSGTYPEFIELD = protobuf.FieldDescriptor()
ChatModule_pb.SENDMSGREQUESTEXTDATAFIELD = protobuf.FieldDescriptor()
ChatModule_pb.CHATMSG_MSG = protobuf.Descriptor()
ChatModule_pb.CHATMSGMSGIDFIELD = protobuf.FieldDescriptor()
ChatModule_pb.CHATMSGCHANNELTYPEFIELD = protobuf.FieldDescriptor()
ChatModule_pb.CHATMSGSENDERIDFIELD = protobuf.FieldDescriptor()
ChatModule_pb.CHATMSGSENDERNAMEFIELD = protobuf.FieldDescriptor()
ChatModule_pb.CHATMSGPORTRAITFIELD = protobuf.FieldDescriptor()
ChatModule_pb.CHATMSGCONTENTFIELD = protobuf.FieldDescriptor()
ChatModule_pb.CHATMSGSENDTIMEFIELD = protobuf.FieldDescriptor()
ChatModule_pb.CHATMSGLEVELFIELD = protobuf.FieldDescriptor()
ChatModule_pb.CHATMSGRECIPIENTIDFIELD = protobuf.FieldDescriptor()
ChatModule_pb.CHATMSGMSGTYPEFIELD = protobuf.FieldDescriptor()
ChatModule_pb.CHATMSGEXTDATAFIELD = protobuf.FieldDescriptor()
ChatModule_pb.REPORTREPLY_MSG = protobuf.Descriptor()
ChatModule_pb.GETREPORTTYPEREQUEST_MSG = protobuf.Descriptor()
ChatModule_pb.CHATMSGPUSH_MSG = protobuf.Descriptor()
ChatModule_pb.CHATMSGPUSHMSGFIELD = protobuf.FieldDescriptor()
ChatModule_pb.WORDTESTREQUEST_MSG = protobuf.Descriptor()
ChatModule_pb.WORDTESTREQUESTCONTENTFIELD = protobuf.FieldDescriptor()
ChatModule_pb.GETREPORTTYPEREPLY_MSG = protobuf.Descriptor()
ChatModule_pb.GETREPORTTYPEREPLYREPORTTYPESFIELD = protobuf.FieldDescriptor()
ChatModule_pb.DELETEOFFLINEMSGREQUEST_MSG = protobuf.Descriptor()
ChatModule_pb.WORDTESTREPLY_MSG = protobuf.Descriptor()
ChatModule_pb.REPORTTYPE_MSG = protobuf.Descriptor()
ChatModule_pb.REPORTTYPEIDFIELD = protobuf.FieldDescriptor()
ChatModule_pb.REPORTTYPEDESCFIELD = protobuf.FieldDescriptor()
ChatModule_pb.DELETEOFFLINEMSGREPLY_MSG.name = "DeleteOfflineMsgReply"
ChatModule_pb.DELETEOFFLINEMSGREPLY_MSG.full_name = ".DeleteOfflineMsgReply"
ChatModule_pb.DELETEOFFLINEMSGREPLY_MSG.nested_types = {}
ChatModule_pb.DELETEOFFLINEMSGREPLY_MSG.enum_types = {}
ChatModule_pb.DELETEOFFLINEMSGREPLY_MSG.fields = {}
ChatModule_pb.DELETEOFFLINEMSGREPLY_MSG.is_extendable = false
ChatModule_pb.DELETEOFFLINEMSGREPLY_MSG.extensions = {}
ChatModule_pb.REPORTREQUESTREPORTEDUSERIDFIELD.name = "reportedUserId"
ChatModule_pb.REPORTREQUESTREPORTEDUSERIDFIELD.full_name = ".ReportRequest.reportedUserId"
ChatModule_pb.REPORTREQUESTREPORTEDUSERIDFIELD.number = 1
ChatModule_pb.REPORTREQUESTREPORTEDUSERIDFIELD.index = 0
ChatModule_pb.REPORTREQUESTREPORTEDUSERIDFIELD.label = 1
ChatModule_pb.REPORTREQUESTREPORTEDUSERIDFIELD.has_default_value = false
ChatModule_pb.REPORTREQUESTREPORTEDUSERIDFIELD.default_value = 0
ChatModule_pb.REPORTREQUESTREPORTEDUSERIDFIELD.type = 4
ChatModule_pb.REPORTREQUESTREPORTEDUSERIDFIELD.cpp_type = 4
ChatModule_pb.REPORTREQUESTREPORTTYPEIDFIELD.name = "reportTypeId"
ChatModule_pb.REPORTREQUESTREPORTTYPEIDFIELD.full_name = ".ReportRequest.reportTypeId"
ChatModule_pb.REPORTREQUESTREPORTTYPEIDFIELD.number = 2
ChatModule_pb.REPORTREQUESTREPORTTYPEIDFIELD.index = 1
ChatModule_pb.REPORTREQUESTREPORTTYPEIDFIELD.label = 1
ChatModule_pb.REPORTREQUESTREPORTTYPEIDFIELD.has_default_value = false
ChatModule_pb.REPORTREQUESTREPORTTYPEIDFIELD.default_value = 0
ChatModule_pb.REPORTREQUESTREPORTTYPEIDFIELD.type = 5
ChatModule_pb.REPORTREQUESTREPORTTYPEIDFIELD.cpp_type = 1
ChatModule_pb.REPORTREQUESTCONTENTFIELD.name = "content"
ChatModule_pb.REPORTREQUESTCONTENTFIELD.full_name = ".ReportRequest.content"
ChatModule_pb.REPORTREQUESTCONTENTFIELD.number = 3
ChatModule_pb.REPORTREQUESTCONTENTFIELD.index = 2
ChatModule_pb.REPORTREQUESTCONTENTFIELD.label = 1
ChatModule_pb.REPORTREQUESTCONTENTFIELD.has_default_value = false
ChatModule_pb.REPORTREQUESTCONTENTFIELD.default_value = ""
ChatModule_pb.REPORTREQUESTCONTENTFIELD.type = 9
ChatModule_pb.REPORTREQUESTCONTENTFIELD.cpp_type = 9
ChatModule_pb.REPORTREQUEST_MSG.name = "ReportRequest"
ChatModule_pb.REPORTREQUEST_MSG.full_name = ".ReportRequest"
ChatModule_pb.REPORTREQUEST_MSG.nested_types = {}
ChatModule_pb.REPORTREQUEST_MSG.enum_types = {}
ChatModule_pb.REPORTREQUEST_MSG.fields = {
	ChatModule_pb.REPORTREQUESTREPORTEDUSERIDFIELD,
	ChatModule_pb.REPORTREQUESTREPORTTYPEIDFIELD,
	ChatModule_pb.REPORTREQUESTCONTENTFIELD
}
ChatModule_pb.REPORTREQUEST_MSG.is_extendable = false
ChatModule_pb.REPORTREQUEST_MSG.extensions = {}
ChatModule_pb.SENDMSGREPLYMESSAGEFIELD.name = "message"
ChatModule_pb.SENDMSGREPLYMESSAGEFIELD.full_name = ".SendMsgReply.message"
ChatModule_pb.SENDMSGREPLYMESSAGEFIELD.number = 1
ChatModule_pb.SENDMSGREPLYMESSAGEFIELD.index = 0
ChatModule_pb.SENDMSGREPLYMESSAGEFIELD.label = 1
ChatModule_pb.SENDMSGREPLYMESSAGEFIELD.has_default_value = false
ChatModule_pb.SENDMSGREPLYMESSAGEFIELD.default_value = ""
ChatModule_pb.SENDMSGREPLYMESSAGEFIELD.type = 9
ChatModule_pb.SENDMSGREPLYMESSAGEFIELD.cpp_type = 9
ChatModule_pb.SENDMSGREPLYCONTENTFIELD.name = "content"
ChatModule_pb.SENDMSGREPLYCONTENTFIELD.full_name = ".SendMsgReply.content"
ChatModule_pb.SENDMSGREPLYCONTENTFIELD.number = 2
ChatModule_pb.SENDMSGREPLYCONTENTFIELD.index = 1
ChatModule_pb.SENDMSGREPLYCONTENTFIELD.label = 1
ChatModule_pb.SENDMSGREPLYCONTENTFIELD.has_default_value = false
ChatModule_pb.SENDMSGREPLYCONTENTFIELD.default_value = ""
ChatModule_pb.SENDMSGREPLYCONTENTFIELD.type = 9
ChatModule_pb.SENDMSGREPLYCONTENTFIELD.cpp_type = 9
ChatModule_pb.SENDMSGREPLYCHANNELTYPEFIELD.name = "channelType"
ChatModule_pb.SENDMSGREPLYCHANNELTYPEFIELD.full_name = ".SendMsgReply.channelType"
ChatModule_pb.SENDMSGREPLYCHANNELTYPEFIELD.number = 3
ChatModule_pb.SENDMSGREPLYCHANNELTYPEFIELD.index = 2
ChatModule_pb.SENDMSGREPLYCHANNELTYPEFIELD.label = 1
ChatModule_pb.SENDMSGREPLYCHANNELTYPEFIELD.has_default_value = false
ChatModule_pb.SENDMSGREPLYCHANNELTYPEFIELD.default_value = 0
ChatModule_pb.SENDMSGREPLYCHANNELTYPEFIELD.type = 13
ChatModule_pb.SENDMSGREPLYCHANNELTYPEFIELD.cpp_type = 3
ChatModule_pb.SENDMSGREPLYMSGTYPEFIELD.name = "msgType"
ChatModule_pb.SENDMSGREPLYMSGTYPEFIELD.full_name = ".SendMsgReply.msgType"
ChatModule_pb.SENDMSGREPLYMSGTYPEFIELD.number = 4
ChatModule_pb.SENDMSGREPLYMSGTYPEFIELD.index = 3
ChatModule_pb.SENDMSGREPLYMSGTYPEFIELD.label = 1
ChatModule_pb.SENDMSGREPLYMSGTYPEFIELD.has_default_value = false
ChatModule_pb.SENDMSGREPLYMSGTYPEFIELD.default_value = 0
ChatModule_pb.SENDMSGREPLYMSGTYPEFIELD.type = 5
ChatModule_pb.SENDMSGREPLYMSGTYPEFIELD.cpp_type = 1
ChatModule_pb.SENDMSGREPLYEXTDATAFIELD.name = "extData"
ChatModule_pb.SENDMSGREPLYEXTDATAFIELD.full_name = ".SendMsgReply.extData"
ChatModule_pb.SENDMSGREPLYEXTDATAFIELD.number = 5
ChatModule_pb.SENDMSGREPLYEXTDATAFIELD.index = 4
ChatModule_pb.SENDMSGREPLYEXTDATAFIELD.label = 1
ChatModule_pb.SENDMSGREPLYEXTDATAFIELD.has_default_value = false
ChatModule_pb.SENDMSGREPLYEXTDATAFIELD.default_value = ""
ChatModule_pb.SENDMSGREPLYEXTDATAFIELD.type = 9
ChatModule_pb.SENDMSGREPLYEXTDATAFIELD.cpp_type = 9
ChatModule_pb.SENDMSGREPLY_MSG.name = "SendMsgReply"
ChatModule_pb.SENDMSGREPLY_MSG.full_name = ".SendMsgReply"
ChatModule_pb.SENDMSGREPLY_MSG.nested_types = {}
ChatModule_pb.SENDMSGREPLY_MSG.enum_types = {}
ChatModule_pb.SENDMSGREPLY_MSG.fields = {
	ChatModule_pb.SENDMSGREPLYMESSAGEFIELD,
	ChatModule_pb.SENDMSGREPLYCONTENTFIELD,
	ChatModule_pb.SENDMSGREPLYCHANNELTYPEFIELD,
	ChatModule_pb.SENDMSGREPLYMSGTYPEFIELD,
	ChatModule_pb.SENDMSGREPLYEXTDATAFIELD
}
ChatModule_pb.SENDMSGREPLY_MSG.is_extendable = false
ChatModule_pb.SENDMSGREPLY_MSG.extensions = {}
ChatModule_pb.SENDMSGREQUESTCHANNELTYPEFIELD.name = "channelType"
ChatModule_pb.SENDMSGREQUESTCHANNELTYPEFIELD.full_name = ".SendMsgRequest.channelType"
ChatModule_pb.SENDMSGREQUESTCHANNELTYPEFIELD.number = 1
ChatModule_pb.SENDMSGREQUESTCHANNELTYPEFIELD.index = 0
ChatModule_pb.SENDMSGREQUESTCHANNELTYPEFIELD.label = 1
ChatModule_pb.SENDMSGREQUESTCHANNELTYPEFIELD.has_default_value = false
ChatModule_pb.SENDMSGREQUESTCHANNELTYPEFIELD.default_value = 0
ChatModule_pb.SENDMSGREQUESTCHANNELTYPEFIELD.type = 13
ChatModule_pb.SENDMSGREQUESTCHANNELTYPEFIELD.cpp_type = 3
ChatModule_pb.SENDMSGREQUESTRECIPIENTIDFIELD.name = "recipientId"
ChatModule_pb.SENDMSGREQUESTRECIPIENTIDFIELD.full_name = ".SendMsgRequest.recipientId"
ChatModule_pb.SENDMSGREQUESTRECIPIENTIDFIELD.number = 2
ChatModule_pb.SENDMSGREQUESTRECIPIENTIDFIELD.index = 1
ChatModule_pb.SENDMSGREQUESTRECIPIENTIDFIELD.label = 1
ChatModule_pb.SENDMSGREQUESTRECIPIENTIDFIELD.has_default_value = false
ChatModule_pb.SENDMSGREQUESTRECIPIENTIDFIELD.default_value = 0
ChatModule_pb.SENDMSGREQUESTRECIPIENTIDFIELD.type = 4
ChatModule_pb.SENDMSGREQUESTRECIPIENTIDFIELD.cpp_type = 4
ChatModule_pb.SENDMSGREQUESTCONTENTFIELD.name = "content"
ChatModule_pb.SENDMSGREQUESTCONTENTFIELD.full_name = ".SendMsgRequest.content"
ChatModule_pb.SENDMSGREQUESTCONTENTFIELD.number = 3
ChatModule_pb.SENDMSGREQUESTCONTENTFIELD.index = 2
ChatModule_pb.SENDMSGREQUESTCONTENTFIELD.label = 1
ChatModule_pb.SENDMSGREQUESTCONTENTFIELD.has_default_value = false
ChatModule_pb.SENDMSGREQUESTCONTENTFIELD.default_value = ""
ChatModule_pb.SENDMSGREQUESTCONTENTFIELD.type = 9
ChatModule_pb.SENDMSGREQUESTCONTENTFIELD.cpp_type = 9
ChatModule_pb.SENDMSGREQUESTMSGTYPEFIELD.name = "msgType"
ChatModule_pb.SENDMSGREQUESTMSGTYPEFIELD.full_name = ".SendMsgRequest.msgType"
ChatModule_pb.SENDMSGREQUESTMSGTYPEFIELD.number = 4
ChatModule_pb.SENDMSGREQUESTMSGTYPEFIELD.index = 3
ChatModule_pb.SENDMSGREQUESTMSGTYPEFIELD.label = 1
ChatModule_pb.SENDMSGREQUESTMSGTYPEFIELD.has_default_value = false
ChatModule_pb.SENDMSGREQUESTMSGTYPEFIELD.default_value = 0
ChatModule_pb.SENDMSGREQUESTMSGTYPEFIELD.type = 5
ChatModule_pb.SENDMSGREQUESTMSGTYPEFIELD.cpp_type = 1
ChatModule_pb.SENDMSGREQUESTEXTDATAFIELD.name = "extData"
ChatModule_pb.SENDMSGREQUESTEXTDATAFIELD.full_name = ".SendMsgRequest.extData"
ChatModule_pb.SENDMSGREQUESTEXTDATAFIELD.number = 5
ChatModule_pb.SENDMSGREQUESTEXTDATAFIELD.index = 4
ChatModule_pb.SENDMSGREQUESTEXTDATAFIELD.label = 1
ChatModule_pb.SENDMSGREQUESTEXTDATAFIELD.has_default_value = false
ChatModule_pb.SENDMSGREQUESTEXTDATAFIELD.default_value = ""
ChatModule_pb.SENDMSGREQUESTEXTDATAFIELD.type = 9
ChatModule_pb.SENDMSGREQUESTEXTDATAFIELD.cpp_type = 9
ChatModule_pb.SENDMSGREQUEST_MSG.name = "SendMsgRequest"
ChatModule_pb.SENDMSGREQUEST_MSG.full_name = ".SendMsgRequest"
ChatModule_pb.SENDMSGREQUEST_MSG.nested_types = {}
ChatModule_pb.SENDMSGREQUEST_MSG.enum_types = {}
ChatModule_pb.SENDMSGREQUEST_MSG.fields = {
	ChatModule_pb.SENDMSGREQUESTCHANNELTYPEFIELD,
	ChatModule_pb.SENDMSGREQUESTRECIPIENTIDFIELD,
	ChatModule_pb.SENDMSGREQUESTCONTENTFIELD,
	ChatModule_pb.SENDMSGREQUESTMSGTYPEFIELD,
	ChatModule_pb.SENDMSGREQUESTEXTDATAFIELD
}
ChatModule_pb.SENDMSGREQUEST_MSG.is_extendable = false
ChatModule_pb.SENDMSGREQUEST_MSG.extensions = {}
ChatModule_pb.CHATMSGMSGIDFIELD.name = "msgId"
ChatModule_pb.CHATMSGMSGIDFIELD.full_name = ".ChatMsg.msgId"
ChatModule_pb.CHATMSGMSGIDFIELD.number = 1
ChatModule_pb.CHATMSGMSGIDFIELD.index = 0
ChatModule_pb.CHATMSGMSGIDFIELD.label = 1
ChatModule_pb.CHATMSGMSGIDFIELD.has_default_value = false
ChatModule_pb.CHATMSGMSGIDFIELD.default_value = 0
ChatModule_pb.CHATMSGMSGIDFIELD.type = 4
ChatModule_pb.CHATMSGMSGIDFIELD.cpp_type = 4
ChatModule_pb.CHATMSGCHANNELTYPEFIELD.name = "channelType"
ChatModule_pb.CHATMSGCHANNELTYPEFIELD.full_name = ".ChatMsg.channelType"
ChatModule_pb.CHATMSGCHANNELTYPEFIELD.number = 2
ChatModule_pb.CHATMSGCHANNELTYPEFIELD.index = 1
ChatModule_pb.CHATMSGCHANNELTYPEFIELD.label = 1
ChatModule_pb.CHATMSGCHANNELTYPEFIELD.has_default_value = false
ChatModule_pb.CHATMSGCHANNELTYPEFIELD.default_value = 0
ChatModule_pb.CHATMSGCHANNELTYPEFIELD.type = 13
ChatModule_pb.CHATMSGCHANNELTYPEFIELD.cpp_type = 3
ChatModule_pb.CHATMSGSENDERIDFIELD.name = "senderId"
ChatModule_pb.CHATMSGSENDERIDFIELD.full_name = ".ChatMsg.senderId"
ChatModule_pb.CHATMSGSENDERIDFIELD.number = 3
ChatModule_pb.CHATMSGSENDERIDFIELD.index = 2
ChatModule_pb.CHATMSGSENDERIDFIELD.label = 1
ChatModule_pb.CHATMSGSENDERIDFIELD.has_default_value = false
ChatModule_pb.CHATMSGSENDERIDFIELD.default_value = 0
ChatModule_pb.CHATMSGSENDERIDFIELD.type = 4
ChatModule_pb.CHATMSGSENDERIDFIELD.cpp_type = 4
ChatModule_pb.CHATMSGSENDERNAMEFIELD.name = "senderName"
ChatModule_pb.CHATMSGSENDERNAMEFIELD.full_name = ".ChatMsg.senderName"
ChatModule_pb.CHATMSGSENDERNAMEFIELD.number = 4
ChatModule_pb.CHATMSGSENDERNAMEFIELD.index = 3
ChatModule_pb.CHATMSGSENDERNAMEFIELD.label = 1
ChatModule_pb.CHATMSGSENDERNAMEFIELD.has_default_value = false
ChatModule_pb.CHATMSGSENDERNAMEFIELD.default_value = ""
ChatModule_pb.CHATMSGSENDERNAMEFIELD.type = 9
ChatModule_pb.CHATMSGSENDERNAMEFIELD.cpp_type = 9
ChatModule_pb.CHATMSGPORTRAITFIELD.name = "portrait"
ChatModule_pb.CHATMSGPORTRAITFIELD.full_name = ".ChatMsg.portrait"
ChatModule_pb.CHATMSGPORTRAITFIELD.number = 5
ChatModule_pb.CHATMSGPORTRAITFIELD.index = 4
ChatModule_pb.CHATMSGPORTRAITFIELD.label = 1
ChatModule_pb.CHATMSGPORTRAITFIELD.has_default_value = false
ChatModule_pb.CHATMSGPORTRAITFIELD.default_value = 0
ChatModule_pb.CHATMSGPORTRAITFIELD.type = 13
ChatModule_pb.CHATMSGPORTRAITFIELD.cpp_type = 3
ChatModule_pb.CHATMSGCONTENTFIELD.name = "content"
ChatModule_pb.CHATMSGCONTENTFIELD.full_name = ".ChatMsg.content"
ChatModule_pb.CHATMSGCONTENTFIELD.number = 6
ChatModule_pb.CHATMSGCONTENTFIELD.index = 5
ChatModule_pb.CHATMSGCONTENTFIELD.label = 1
ChatModule_pb.CHATMSGCONTENTFIELD.has_default_value = false
ChatModule_pb.CHATMSGCONTENTFIELD.default_value = ""
ChatModule_pb.CHATMSGCONTENTFIELD.type = 9
ChatModule_pb.CHATMSGCONTENTFIELD.cpp_type = 9
ChatModule_pb.CHATMSGSENDTIMEFIELD.name = "sendTime"
ChatModule_pb.CHATMSGSENDTIMEFIELD.full_name = ".ChatMsg.sendTime"
ChatModule_pb.CHATMSGSENDTIMEFIELD.number = 7
ChatModule_pb.CHATMSGSENDTIMEFIELD.index = 6
ChatModule_pb.CHATMSGSENDTIMEFIELD.label = 1
ChatModule_pb.CHATMSGSENDTIMEFIELD.has_default_value = false
ChatModule_pb.CHATMSGSENDTIMEFIELD.default_value = 0
ChatModule_pb.CHATMSGSENDTIMEFIELD.type = 4
ChatModule_pb.CHATMSGSENDTIMEFIELD.cpp_type = 4
ChatModule_pb.CHATMSGLEVELFIELD.name = "level"
ChatModule_pb.CHATMSGLEVELFIELD.full_name = ".ChatMsg.level"
ChatModule_pb.CHATMSGLEVELFIELD.number = 8
ChatModule_pb.CHATMSGLEVELFIELD.index = 7
ChatModule_pb.CHATMSGLEVELFIELD.label = 1
ChatModule_pb.CHATMSGLEVELFIELD.has_default_value = false
ChatModule_pb.CHATMSGLEVELFIELD.default_value = 0
ChatModule_pb.CHATMSGLEVELFIELD.type = 13
ChatModule_pb.CHATMSGLEVELFIELD.cpp_type = 3
ChatModule_pb.CHATMSGRECIPIENTIDFIELD.name = "recipientId"
ChatModule_pb.CHATMSGRECIPIENTIDFIELD.full_name = ".ChatMsg.recipientId"
ChatModule_pb.CHATMSGRECIPIENTIDFIELD.number = 9
ChatModule_pb.CHATMSGRECIPIENTIDFIELD.index = 8
ChatModule_pb.CHATMSGRECIPIENTIDFIELD.label = 1
ChatModule_pb.CHATMSGRECIPIENTIDFIELD.has_default_value = false
ChatModule_pb.CHATMSGRECIPIENTIDFIELD.default_value = 0
ChatModule_pb.CHATMSGRECIPIENTIDFIELD.type = 4
ChatModule_pb.CHATMSGRECIPIENTIDFIELD.cpp_type = 4
ChatModule_pb.CHATMSGMSGTYPEFIELD.name = "msgType"
ChatModule_pb.CHATMSGMSGTYPEFIELD.full_name = ".ChatMsg.msgType"
ChatModule_pb.CHATMSGMSGTYPEFIELD.number = 10
ChatModule_pb.CHATMSGMSGTYPEFIELD.index = 9
ChatModule_pb.CHATMSGMSGTYPEFIELD.label = 1
ChatModule_pb.CHATMSGMSGTYPEFIELD.has_default_value = false
ChatModule_pb.CHATMSGMSGTYPEFIELD.default_value = 0
ChatModule_pb.CHATMSGMSGTYPEFIELD.type = 5
ChatModule_pb.CHATMSGMSGTYPEFIELD.cpp_type = 1
ChatModule_pb.CHATMSGEXTDATAFIELD.name = "extData"
ChatModule_pb.CHATMSGEXTDATAFIELD.full_name = ".ChatMsg.extData"
ChatModule_pb.CHATMSGEXTDATAFIELD.number = 11
ChatModule_pb.CHATMSGEXTDATAFIELD.index = 10
ChatModule_pb.CHATMSGEXTDATAFIELD.label = 1
ChatModule_pb.CHATMSGEXTDATAFIELD.has_default_value = false
ChatModule_pb.CHATMSGEXTDATAFIELD.default_value = ""
ChatModule_pb.CHATMSGEXTDATAFIELD.type = 9
ChatModule_pb.CHATMSGEXTDATAFIELD.cpp_type = 9
ChatModule_pb.CHATMSG_MSG.name = "ChatMsg"
ChatModule_pb.CHATMSG_MSG.full_name = ".ChatMsg"
ChatModule_pb.CHATMSG_MSG.nested_types = {}
ChatModule_pb.CHATMSG_MSG.enum_types = {}
ChatModule_pb.CHATMSG_MSG.fields = {
	ChatModule_pb.CHATMSGMSGIDFIELD,
	ChatModule_pb.CHATMSGCHANNELTYPEFIELD,
	ChatModule_pb.CHATMSGSENDERIDFIELD,
	ChatModule_pb.CHATMSGSENDERNAMEFIELD,
	ChatModule_pb.CHATMSGPORTRAITFIELD,
	ChatModule_pb.CHATMSGCONTENTFIELD,
	ChatModule_pb.CHATMSGSENDTIMEFIELD,
	ChatModule_pb.CHATMSGLEVELFIELD,
	ChatModule_pb.CHATMSGRECIPIENTIDFIELD,
	ChatModule_pb.CHATMSGMSGTYPEFIELD,
	ChatModule_pb.CHATMSGEXTDATAFIELD
}
ChatModule_pb.CHATMSG_MSG.is_extendable = false
ChatModule_pb.CHATMSG_MSG.extensions = {}
ChatModule_pb.REPORTREPLY_MSG.name = "ReportReply"
ChatModule_pb.REPORTREPLY_MSG.full_name = ".ReportReply"
ChatModule_pb.REPORTREPLY_MSG.nested_types = {}
ChatModule_pb.REPORTREPLY_MSG.enum_types = {}
ChatModule_pb.REPORTREPLY_MSG.fields = {}
ChatModule_pb.REPORTREPLY_MSG.is_extendable = false
ChatModule_pb.REPORTREPLY_MSG.extensions = {}
ChatModule_pb.GETREPORTTYPEREQUEST_MSG.name = "GetReportTypeRequest"
ChatModule_pb.GETREPORTTYPEREQUEST_MSG.full_name = ".GetReportTypeRequest"
ChatModule_pb.GETREPORTTYPEREQUEST_MSG.nested_types = {}
ChatModule_pb.GETREPORTTYPEREQUEST_MSG.enum_types = {}
ChatModule_pb.GETREPORTTYPEREQUEST_MSG.fields = {}
ChatModule_pb.GETREPORTTYPEREQUEST_MSG.is_extendable = false
ChatModule_pb.GETREPORTTYPEREQUEST_MSG.extensions = {}
ChatModule_pb.CHATMSGPUSHMSGFIELD.name = "msg"
ChatModule_pb.CHATMSGPUSHMSGFIELD.full_name = ".ChatMsgPush.msg"
ChatModule_pb.CHATMSGPUSHMSGFIELD.number = 1
ChatModule_pb.CHATMSGPUSHMSGFIELD.index = 0
ChatModule_pb.CHATMSGPUSHMSGFIELD.label = 3
ChatModule_pb.CHATMSGPUSHMSGFIELD.has_default_value = false
ChatModule_pb.CHATMSGPUSHMSGFIELD.default_value = {}
ChatModule_pb.CHATMSGPUSHMSGFIELD.message_type = ChatModule_pb.CHATMSG_MSG
ChatModule_pb.CHATMSGPUSHMSGFIELD.type = 11
ChatModule_pb.CHATMSGPUSHMSGFIELD.cpp_type = 10
ChatModule_pb.CHATMSGPUSH_MSG.name = "ChatMsgPush"
ChatModule_pb.CHATMSGPUSH_MSG.full_name = ".ChatMsgPush"
ChatModule_pb.CHATMSGPUSH_MSG.nested_types = {}
ChatModule_pb.CHATMSGPUSH_MSG.enum_types = {}
ChatModule_pb.CHATMSGPUSH_MSG.fields = {
	ChatModule_pb.CHATMSGPUSHMSGFIELD
}
ChatModule_pb.CHATMSGPUSH_MSG.is_extendable = false
ChatModule_pb.CHATMSGPUSH_MSG.extensions = {}
ChatModule_pb.WORDTESTREQUESTCONTENTFIELD.name = "content"
ChatModule_pb.WORDTESTREQUESTCONTENTFIELD.full_name = ".WordTestRequest.content"
ChatModule_pb.WORDTESTREQUESTCONTENTFIELD.number = 1
ChatModule_pb.WORDTESTREQUESTCONTENTFIELD.index = 0
ChatModule_pb.WORDTESTREQUESTCONTENTFIELD.label = 1
ChatModule_pb.WORDTESTREQUESTCONTENTFIELD.has_default_value = false
ChatModule_pb.WORDTESTREQUESTCONTENTFIELD.default_value = ""
ChatModule_pb.WORDTESTREQUESTCONTENTFIELD.type = 9
ChatModule_pb.WORDTESTREQUESTCONTENTFIELD.cpp_type = 9
ChatModule_pb.WORDTESTREQUEST_MSG.name = "WordTestRequest"
ChatModule_pb.WORDTESTREQUEST_MSG.full_name = ".WordTestRequest"
ChatModule_pb.WORDTESTREQUEST_MSG.nested_types = {}
ChatModule_pb.WORDTESTREQUEST_MSG.enum_types = {}
ChatModule_pb.WORDTESTREQUEST_MSG.fields = {
	ChatModule_pb.WORDTESTREQUESTCONTENTFIELD
}
ChatModule_pb.WORDTESTREQUEST_MSG.is_extendable = false
ChatModule_pb.WORDTESTREQUEST_MSG.extensions = {}
ChatModule_pb.GETREPORTTYPEREPLYREPORTTYPESFIELD.name = "reportTypes"
ChatModule_pb.GETREPORTTYPEREPLYREPORTTYPESFIELD.full_name = ".GetReportTypeReply.reportTypes"
ChatModule_pb.GETREPORTTYPEREPLYREPORTTYPESFIELD.number = 1
ChatModule_pb.GETREPORTTYPEREPLYREPORTTYPESFIELD.index = 0
ChatModule_pb.GETREPORTTYPEREPLYREPORTTYPESFIELD.label = 3
ChatModule_pb.GETREPORTTYPEREPLYREPORTTYPESFIELD.has_default_value = false
ChatModule_pb.GETREPORTTYPEREPLYREPORTTYPESFIELD.default_value = {}
ChatModule_pb.GETREPORTTYPEREPLYREPORTTYPESFIELD.message_type = ChatModule_pb.REPORTTYPE_MSG
ChatModule_pb.GETREPORTTYPEREPLYREPORTTYPESFIELD.type = 11
ChatModule_pb.GETREPORTTYPEREPLYREPORTTYPESFIELD.cpp_type = 10
ChatModule_pb.GETREPORTTYPEREPLY_MSG.name = "GetReportTypeReply"
ChatModule_pb.GETREPORTTYPEREPLY_MSG.full_name = ".GetReportTypeReply"
ChatModule_pb.GETREPORTTYPEREPLY_MSG.nested_types = {}
ChatModule_pb.GETREPORTTYPEREPLY_MSG.enum_types = {}
ChatModule_pb.GETREPORTTYPEREPLY_MSG.fields = {
	ChatModule_pb.GETREPORTTYPEREPLYREPORTTYPESFIELD
}
ChatModule_pb.GETREPORTTYPEREPLY_MSG.is_extendable = false
ChatModule_pb.GETREPORTTYPEREPLY_MSG.extensions = {}
ChatModule_pb.DELETEOFFLINEMSGREQUEST_MSG.name = "DeleteOfflineMsgRequest"
ChatModule_pb.DELETEOFFLINEMSGREQUEST_MSG.full_name = ".DeleteOfflineMsgRequest"
ChatModule_pb.DELETEOFFLINEMSGREQUEST_MSG.nested_types = {}
ChatModule_pb.DELETEOFFLINEMSGREQUEST_MSG.enum_types = {}
ChatModule_pb.DELETEOFFLINEMSGREQUEST_MSG.fields = {}
ChatModule_pb.DELETEOFFLINEMSGREQUEST_MSG.is_extendable = false
ChatModule_pb.DELETEOFFLINEMSGREQUEST_MSG.extensions = {}
ChatModule_pb.WORDTESTREPLY_MSG.name = "WordTestReply"
ChatModule_pb.WORDTESTREPLY_MSG.full_name = ".WordTestReply"
ChatModule_pb.WORDTESTREPLY_MSG.nested_types = {}
ChatModule_pb.WORDTESTREPLY_MSG.enum_types = {}
ChatModule_pb.WORDTESTREPLY_MSG.fields = {}
ChatModule_pb.WORDTESTREPLY_MSG.is_extendable = false
ChatModule_pb.WORDTESTREPLY_MSG.extensions = {}
ChatModule_pb.REPORTTYPEIDFIELD.name = "id"
ChatModule_pb.REPORTTYPEIDFIELD.full_name = ".ReportType.id"
ChatModule_pb.REPORTTYPEIDFIELD.number = 1
ChatModule_pb.REPORTTYPEIDFIELD.index = 0
ChatModule_pb.REPORTTYPEIDFIELD.label = 1
ChatModule_pb.REPORTTYPEIDFIELD.has_default_value = false
ChatModule_pb.REPORTTYPEIDFIELD.default_value = 0
ChatModule_pb.REPORTTYPEIDFIELD.type = 5
ChatModule_pb.REPORTTYPEIDFIELD.cpp_type = 1
ChatModule_pb.REPORTTYPEDESCFIELD.name = "desc"
ChatModule_pb.REPORTTYPEDESCFIELD.full_name = ".ReportType.desc"
ChatModule_pb.REPORTTYPEDESCFIELD.number = 2
ChatModule_pb.REPORTTYPEDESCFIELD.index = 1
ChatModule_pb.REPORTTYPEDESCFIELD.label = 1
ChatModule_pb.REPORTTYPEDESCFIELD.has_default_value = false
ChatModule_pb.REPORTTYPEDESCFIELD.default_value = ""
ChatModule_pb.REPORTTYPEDESCFIELD.type = 9
ChatModule_pb.REPORTTYPEDESCFIELD.cpp_type = 9
ChatModule_pb.REPORTTYPE_MSG.name = "ReportType"
ChatModule_pb.REPORTTYPE_MSG.full_name = ".ReportType"
ChatModule_pb.REPORTTYPE_MSG.nested_types = {}
ChatModule_pb.REPORTTYPE_MSG.enum_types = {}
ChatModule_pb.REPORTTYPE_MSG.fields = {
	ChatModule_pb.REPORTTYPEIDFIELD,
	ChatModule_pb.REPORTTYPEDESCFIELD
}
ChatModule_pb.REPORTTYPE_MSG.is_extendable = false
ChatModule_pb.REPORTTYPE_MSG.extensions = {}
ChatModule_pb.ChatMsg = protobuf.Message(ChatModule_pb.CHATMSG_MSG)
ChatModule_pb.ChatMsgPush = protobuf.Message(ChatModule_pb.CHATMSGPUSH_MSG)
ChatModule_pb.DeleteOfflineMsgReply = protobuf.Message(ChatModule_pb.DELETEOFFLINEMSGREPLY_MSG)
ChatModule_pb.DeleteOfflineMsgRequest = protobuf.Message(ChatModule_pb.DELETEOFFLINEMSGREQUEST_MSG)
ChatModule_pb.GetReportTypeReply = protobuf.Message(ChatModule_pb.GETREPORTTYPEREPLY_MSG)
ChatModule_pb.GetReportTypeRequest = protobuf.Message(ChatModule_pb.GETREPORTTYPEREQUEST_MSG)
ChatModule_pb.ReportReply = protobuf.Message(ChatModule_pb.REPORTREPLY_MSG)
ChatModule_pb.ReportRequest = protobuf.Message(ChatModule_pb.REPORTREQUEST_MSG)
ChatModule_pb.ReportType = protobuf.Message(ChatModule_pb.REPORTTYPE_MSG)
ChatModule_pb.SendMsgReply = protobuf.Message(ChatModule_pb.SENDMSGREPLY_MSG)
ChatModule_pb.SendMsgRequest = protobuf.Message(ChatModule_pb.SENDMSGREQUEST_MSG)
ChatModule_pb.WordTestReply = protobuf.Message(ChatModule_pb.WORDTESTREPLY_MSG)
ChatModule_pb.WordTestRequest = protobuf.Message(ChatModule_pb.WORDTESTREQUEST_MSG)

return ChatModule_pb
