-- chunkname: @modules/proto/MailModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.MailModule_pb", package.seeall)

local MailModule_pb = {}

MailModule_pb.NEWMAILPUSH_MSG = protobuf.Descriptor()
MailModule_pb.NEWMAILPUSHMAILFIELD = protobuf.FieldDescriptor()
MailModule_pb.READMAILBATCHREQUEST_MSG = protobuf.Descriptor()
MailModule_pb.READMAILBATCHREQUESTTYPEFIELD = protobuf.FieldDescriptor()
MailModule_pb.DELETEMAILBATCHREQUEST_MSG = protobuf.Descriptor()
MailModule_pb.DELETEMAILBATCHREQUESTTYPEFIELD = protobuf.FieldDescriptor()
MailModule_pb.READMAILREPLY_MSG = protobuf.Descriptor()
MailModule_pb.READMAILREPLYINCRIDFIELD = protobuf.FieldDescriptor()
MailModule_pb.MARKMAILJUMPREQUEST_MSG = protobuf.Descriptor()
MailModule_pb.MARKMAILJUMPREQUESTINCRIDFIELD = protobuf.FieldDescriptor()
MailModule_pb.DELETEMAILBATCHREPLY_MSG = protobuf.Descriptor()
MailModule_pb.DELETEMAILBATCHREPLYINCRIDSFIELD = protobuf.FieldDescriptor()
MailModule_pb.MARKMAILJUMPREPLY_MSG = protobuf.Descriptor()
MailModule_pb.MARKMAILJUMPREPLYINCRIDFIELD = protobuf.FieldDescriptor()
MailModule_pb.READMAILREQUEST_MSG = protobuf.Descriptor()
MailModule_pb.READMAILREQUESTINCRIDFIELD = protobuf.FieldDescriptor()
MailModule_pb.MAILLOCKREPLY_MSG = protobuf.Descriptor()
MailModule_pb.MAILLOCKREPLYINCRIDFIELD = protobuf.FieldDescriptor()
MailModule_pb.MAILLOCKREPLYLOCKFIELD = protobuf.FieldDescriptor()
MailModule_pb.GETALLMAILSREPLY_MSG = protobuf.Descriptor()
MailModule_pb.GETALLMAILSREPLYMAILSFIELD = protobuf.FieldDescriptor()
MailModule_pb.MAIL_MSG = protobuf.Descriptor()
MailModule_pb.MAILINCRIDFIELD = protobuf.FieldDescriptor()
MailModule_pb.MAILMAILIDFIELD = protobuf.FieldDescriptor()
MailModule_pb.MAILPARAMSFIELD = protobuf.FieldDescriptor()
MailModule_pb.MAILATTACHMENTFIELD = protobuf.FieldDescriptor()
MailModule_pb.MAILSTATEFIELD = protobuf.FieldDescriptor()
MailModule_pb.MAILCREATETIMEFIELD = protobuf.FieldDescriptor()
MailModule_pb.MAILSENDERFIELD = protobuf.FieldDescriptor()
MailModule_pb.MAILTITLEFIELD = protobuf.FieldDescriptor()
MailModule_pb.MAILCONTENTFIELD = protobuf.FieldDescriptor()
MailModule_pb.MAILCOPYFIELD = protobuf.FieldDescriptor()
MailModule_pb.MAILEXPIRETIMEFIELD = protobuf.FieldDescriptor()
MailModule_pb.MAILSENDERTYPEFIELD = protobuf.FieldDescriptor()
MailModule_pb.MAILJUMPTITLEFIELD = protobuf.FieldDescriptor()
MailModule_pb.MAILJUMPFIELD = protobuf.FieldDescriptor()
MailModule_pb.MAILISLOCKFIELD = protobuf.FieldDescriptor()
MailModule_pb.DELETEMAILSPUSH_MSG = protobuf.Descriptor()
MailModule_pb.DELETEMAILSPUSHINCRIDSFIELD = protobuf.FieldDescriptor()
MailModule_pb.GETALLMAILSREQUEST_MSG = protobuf.Descriptor()
MailModule_pb.AUTOREADMAILPUSH_MSG = protobuf.Descriptor()
MailModule_pb.AUTOREADMAILPUSHINCRIDSFIELD = protobuf.FieldDescriptor()
MailModule_pb.READMAILBATCHREPLY_MSG = protobuf.Descriptor()
MailModule_pb.READMAILBATCHREPLYINCRIDSFIELD = protobuf.FieldDescriptor()
MailModule_pb.MAILLOCKREQUEST_MSG = protobuf.Descriptor()
MailModule_pb.MAILLOCKREQUESTINCRIDFIELD = protobuf.FieldDescriptor()
MailModule_pb.MAILLOCKREQUESTLOCKFIELD = protobuf.FieldDescriptor()
MailModule_pb.NEWMAILPUSHMAILFIELD.name = "mail"
MailModule_pb.NEWMAILPUSHMAILFIELD.full_name = ".NewMailPush.mail"
MailModule_pb.NEWMAILPUSHMAILFIELD.number = 1
MailModule_pb.NEWMAILPUSHMAILFIELD.index = 0
MailModule_pb.NEWMAILPUSHMAILFIELD.label = 1
MailModule_pb.NEWMAILPUSHMAILFIELD.has_default_value = false
MailModule_pb.NEWMAILPUSHMAILFIELD.default_value = nil
MailModule_pb.NEWMAILPUSHMAILFIELD.message_type = MailModule_pb.MAIL_MSG
MailModule_pb.NEWMAILPUSHMAILFIELD.type = 11
MailModule_pb.NEWMAILPUSHMAILFIELD.cpp_type = 10
MailModule_pb.NEWMAILPUSH_MSG.name = "NewMailPush"
MailModule_pb.NEWMAILPUSH_MSG.full_name = ".NewMailPush"
MailModule_pb.NEWMAILPUSH_MSG.nested_types = {}
MailModule_pb.NEWMAILPUSH_MSG.enum_types = {}
MailModule_pb.NEWMAILPUSH_MSG.fields = {
	MailModule_pb.NEWMAILPUSHMAILFIELD
}
MailModule_pb.NEWMAILPUSH_MSG.is_extendable = false
MailModule_pb.NEWMAILPUSH_MSG.extensions = {}
MailModule_pb.READMAILBATCHREQUESTTYPEFIELD.name = "type"
MailModule_pb.READMAILBATCHREQUESTTYPEFIELD.full_name = ".ReadMailBatchRequest.type"
MailModule_pb.READMAILBATCHREQUESTTYPEFIELD.number = 1
MailModule_pb.READMAILBATCHREQUESTTYPEFIELD.index = 0
MailModule_pb.READMAILBATCHREQUESTTYPEFIELD.label = 1
MailModule_pb.READMAILBATCHREQUESTTYPEFIELD.has_default_value = false
MailModule_pb.READMAILBATCHREQUESTTYPEFIELD.default_value = 0
MailModule_pb.READMAILBATCHREQUESTTYPEFIELD.type = 13
MailModule_pb.READMAILBATCHREQUESTTYPEFIELD.cpp_type = 3
MailModule_pb.READMAILBATCHREQUEST_MSG.name = "ReadMailBatchRequest"
MailModule_pb.READMAILBATCHREQUEST_MSG.full_name = ".ReadMailBatchRequest"
MailModule_pb.READMAILBATCHREQUEST_MSG.nested_types = {}
MailModule_pb.READMAILBATCHREQUEST_MSG.enum_types = {}
MailModule_pb.READMAILBATCHREQUEST_MSG.fields = {
	MailModule_pb.READMAILBATCHREQUESTTYPEFIELD
}
MailModule_pb.READMAILBATCHREQUEST_MSG.is_extendable = false
MailModule_pb.READMAILBATCHREQUEST_MSG.extensions = {}
MailModule_pb.DELETEMAILBATCHREQUESTTYPEFIELD.name = "type"
MailModule_pb.DELETEMAILBATCHREQUESTTYPEFIELD.full_name = ".DeleteMailBatchRequest.type"
MailModule_pb.DELETEMAILBATCHREQUESTTYPEFIELD.number = 1
MailModule_pb.DELETEMAILBATCHREQUESTTYPEFIELD.index = 0
MailModule_pb.DELETEMAILBATCHREQUESTTYPEFIELD.label = 1
MailModule_pb.DELETEMAILBATCHREQUESTTYPEFIELD.has_default_value = false
MailModule_pb.DELETEMAILBATCHREQUESTTYPEFIELD.default_value = 0
MailModule_pb.DELETEMAILBATCHREQUESTTYPEFIELD.type = 13
MailModule_pb.DELETEMAILBATCHREQUESTTYPEFIELD.cpp_type = 3
MailModule_pb.DELETEMAILBATCHREQUEST_MSG.name = "DeleteMailBatchRequest"
MailModule_pb.DELETEMAILBATCHREQUEST_MSG.full_name = ".DeleteMailBatchRequest"
MailModule_pb.DELETEMAILBATCHREQUEST_MSG.nested_types = {}
MailModule_pb.DELETEMAILBATCHREQUEST_MSG.enum_types = {}
MailModule_pb.DELETEMAILBATCHREQUEST_MSG.fields = {
	MailModule_pb.DELETEMAILBATCHREQUESTTYPEFIELD
}
MailModule_pb.DELETEMAILBATCHREQUEST_MSG.is_extendable = false
MailModule_pb.DELETEMAILBATCHREQUEST_MSG.extensions = {}
MailModule_pb.READMAILREPLYINCRIDFIELD.name = "incrId"
MailModule_pb.READMAILREPLYINCRIDFIELD.full_name = ".ReadMailReply.incrId"
MailModule_pb.READMAILREPLYINCRIDFIELD.number = 1
MailModule_pb.READMAILREPLYINCRIDFIELD.index = 0
MailModule_pb.READMAILREPLYINCRIDFIELD.label = 1
MailModule_pb.READMAILREPLYINCRIDFIELD.has_default_value = false
MailModule_pb.READMAILREPLYINCRIDFIELD.default_value = 0
MailModule_pb.READMAILREPLYINCRIDFIELD.type = 4
MailModule_pb.READMAILREPLYINCRIDFIELD.cpp_type = 4
MailModule_pb.READMAILREPLY_MSG.name = "ReadMailReply"
MailModule_pb.READMAILREPLY_MSG.full_name = ".ReadMailReply"
MailModule_pb.READMAILREPLY_MSG.nested_types = {}
MailModule_pb.READMAILREPLY_MSG.enum_types = {}
MailModule_pb.READMAILREPLY_MSG.fields = {
	MailModule_pb.READMAILREPLYINCRIDFIELD
}
MailModule_pb.READMAILREPLY_MSG.is_extendable = false
MailModule_pb.READMAILREPLY_MSG.extensions = {}
MailModule_pb.MARKMAILJUMPREQUESTINCRIDFIELD.name = "incrId"
MailModule_pb.MARKMAILJUMPREQUESTINCRIDFIELD.full_name = ".MarkMailJumpRequest.incrId"
MailModule_pb.MARKMAILJUMPREQUESTINCRIDFIELD.number = 1
MailModule_pb.MARKMAILJUMPREQUESTINCRIDFIELD.index = 0
MailModule_pb.MARKMAILJUMPREQUESTINCRIDFIELD.label = 1
MailModule_pb.MARKMAILJUMPREQUESTINCRIDFIELD.has_default_value = false
MailModule_pb.MARKMAILJUMPREQUESTINCRIDFIELD.default_value = 0
MailModule_pb.MARKMAILJUMPREQUESTINCRIDFIELD.type = 4
MailModule_pb.MARKMAILJUMPREQUESTINCRIDFIELD.cpp_type = 4
MailModule_pb.MARKMAILJUMPREQUEST_MSG.name = "MarkMailJumpRequest"
MailModule_pb.MARKMAILJUMPREQUEST_MSG.full_name = ".MarkMailJumpRequest"
MailModule_pb.MARKMAILJUMPREQUEST_MSG.nested_types = {}
MailModule_pb.MARKMAILJUMPREQUEST_MSG.enum_types = {}
MailModule_pb.MARKMAILJUMPREQUEST_MSG.fields = {
	MailModule_pb.MARKMAILJUMPREQUESTINCRIDFIELD
}
MailModule_pb.MARKMAILJUMPREQUEST_MSG.is_extendable = false
MailModule_pb.MARKMAILJUMPREQUEST_MSG.extensions = {}
MailModule_pb.DELETEMAILBATCHREPLYINCRIDSFIELD.name = "incrIds"
MailModule_pb.DELETEMAILBATCHREPLYINCRIDSFIELD.full_name = ".DeleteMailBatchReply.incrIds"
MailModule_pb.DELETEMAILBATCHREPLYINCRIDSFIELD.number = 1
MailModule_pb.DELETEMAILBATCHREPLYINCRIDSFIELD.index = 0
MailModule_pb.DELETEMAILBATCHREPLYINCRIDSFIELD.label = 3
MailModule_pb.DELETEMAILBATCHREPLYINCRIDSFIELD.has_default_value = false
MailModule_pb.DELETEMAILBATCHREPLYINCRIDSFIELD.default_value = {}
MailModule_pb.DELETEMAILBATCHREPLYINCRIDSFIELD.type = 4
MailModule_pb.DELETEMAILBATCHREPLYINCRIDSFIELD.cpp_type = 4
MailModule_pb.DELETEMAILBATCHREPLY_MSG.name = "DeleteMailBatchReply"
MailModule_pb.DELETEMAILBATCHREPLY_MSG.full_name = ".DeleteMailBatchReply"
MailModule_pb.DELETEMAILBATCHREPLY_MSG.nested_types = {}
MailModule_pb.DELETEMAILBATCHREPLY_MSG.enum_types = {}
MailModule_pb.DELETEMAILBATCHREPLY_MSG.fields = {
	MailModule_pb.DELETEMAILBATCHREPLYINCRIDSFIELD
}
MailModule_pb.DELETEMAILBATCHREPLY_MSG.is_extendable = false
MailModule_pb.DELETEMAILBATCHREPLY_MSG.extensions = {}
MailModule_pb.MARKMAILJUMPREPLYINCRIDFIELD.name = "incrId"
MailModule_pb.MARKMAILJUMPREPLYINCRIDFIELD.full_name = ".MarkMailJumpReply.incrId"
MailModule_pb.MARKMAILJUMPREPLYINCRIDFIELD.number = 1
MailModule_pb.MARKMAILJUMPREPLYINCRIDFIELD.index = 0
MailModule_pb.MARKMAILJUMPREPLYINCRIDFIELD.label = 1
MailModule_pb.MARKMAILJUMPREPLYINCRIDFIELD.has_default_value = false
MailModule_pb.MARKMAILJUMPREPLYINCRIDFIELD.default_value = 0
MailModule_pb.MARKMAILJUMPREPLYINCRIDFIELD.type = 4
MailModule_pb.MARKMAILJUMPREPLYINCRIDFIELD.cpp_type = 4
MailModule_pb.MARKMAILJUMPREPLY_MSG.name = "MarkMailJumpReply"
MailModule_pb.MARKMAILJUMPREPLY_MSG.full_name = ".MarkMailJumpReply"
MailModule_pb.MARKMAILJUMPREPLY_MSG.nested_types = {}
MailModule_pb.MARKMAILJUMPREPLY_MSG.enum_types = {}
MailModule_pb.MARKMAILJUMPREPLY_MSG.fields = {
	MailModule_pb.MARKMAILJUMPREPLYINCRIDFIELD
}
MailModule_pb.MARKMAILJUMPREPLY_MSG.is_extendable = false
MailModule_pb.MARKMAILJUMPREPLY_MSG.extensions = {}
MailModule_pb.READMAILREQUESTINCRIDFIELD.name = "incrId"
MailModule_pb.READMAILREQUESTINCRIDFIELD.full_name = ".ReadMailRequest.incrId"
MailModule_pb.READMAILREQUESTINCRIDFIELD.number = 1
MailModule_pb.READMAILREQUESTINCRIDFIELD.index = 0
MailModule_pb.READMAILREQUESTINCRIDFIELD.label = 1
MailModule_pb.READMAILREQUESTINCRIDFIELD.has_default_value = false
MailModule_pb.READMAILREQUESTINCRIDFIELD.default_value = 0
MailModule_pb.READMAILREQUESTINCRIDFIELD.type = 4
MailModule_pb.READMAILREQUESTINCRIDFIELD.cpp_type = 4
MailModule_pb.READMAILREQUEST_MSG.name = "ReadMailRequest"
MailModule_pb.READMAILREQUEST_MSG.full_name = ".ReadMailRequest"
MailModule_pb.READMAILREQUEST_MSG.nested_types = {}
MailModule_pb.READMAILREQUEST_MSG.enum_types = {}
MailModule_pb.READMAILREQUEST_MSG.fields = {
	MailModule_pb.READMAILREQUESTINCRIDFIELD
}
MailModule_pb.READMAILREQUEST_MSG.is_extendable = false
MailModule_pb.READMAILREQUEST_MSG.extensions = {}
MailModule_pb.MAILLOCKREPLYINCRIDFIELD.name = "incrId"
MailModule_pb.MAILLOCKREPLYINCRIDFIELD.full_name = ".MailLockReply.incrId"
MailModule_pb.MAILLOCKREPLYINCRIDFIELD.number = 1
MailModule_pb.MAILLOCKREPLYINCRIDFIELD.index = 0
MailModule_pb.MAILLOCKREPLYINCRIDFIELD.label = 1
MailModule_pb.MAILLOCKREPLYINCRIDFIELD.has_default_value = false
MailModule_pb.MAILLOCKREPLYINCRIDFIELD.default_value = 0
MailModule_pb.MAILLOCKREPLYINCRIDFIELD.type = 4
MailModule_pb.MAILLOCKREPLYINCRIDFIELD.cpp_type = 4
MailModule_pb.MAILLOCKREPLYLOCKFIELD.name = "lock"
MailModule_pb.MAILLOCKREPLYLOCKFIELD.full_name = ".MailLockReply.lock"
MailModule_pb.MAILLOCKREPLYLOCKFIELD.number = 2
MailModule_pb.MAILLOCKREPLYLOCKFIELD.index = 1
MailModule_pb.MAILLOCKREPLYLOCKFIELD.label = 1
MailModule_pb.MAILLOCKREPLYLOCKFIELD.has_default_value = false
MailModule_pb.MAILLOCKREPLYLOCKFIELD.default_value = false
MailModule_pb.MAILLOCKREPLYLOCKFIELD.type = 8
MailModule_pb.MAILLOCKREPLYLOCKFIELD.cpp_type = 7
MailModule_pb.MAILLOCKREPLY_MSG.name = "MailLockReply"
MailModule_pb.MAILLOCKREPLY_MSG.full_name = ".MailLockReply"
MailModule_pb.MAILLOCKREPLY_MSG.nested_types = {}
MailModule_pb.MAILLOCKREPLY_MSG.enum_types = {}
MailModule_pb.MAILLOCKREPLY_MSG.fields = {
	MailModule_pb.MAILLOCKREPLYINCRIDFIELD,
	MailModule_pb.MAILLOCKREPLYLOCKFIELD
}
MailModule_pb.MAILLOCKREPLY_MSG.is_extendable = false
MailModule_pb.MAILLOCKREPLY_MSG.extensions = {}
MailModule_pb.GETALLMAILSREPLYMAILSFIELD.name = "mails"
MailModule_pb.GETALLMAILSREPLYMAILSFIELD.full_name = ".GetAllMailsReply.mails"
MailModule_pb.GETALLMAILSREPLYMAILSFIELD.number = 1
MailModule_pb.GETALLMAILSREPLYMAILSFIELD.index = 0
MailModule_pb.GETALLMAILSREPLYMAILSFIELD.label = 3
MailModule_pb.GETALLMAILSREPLYMAILSFIELD.has_default_value = false
MailModule_pb.GETALLMAILSREPLYMAILSFIELD.default_value = {}
MailModule_pb.GETALLMAILSREPLYMAILSFIELD.message_type = MailModule_pb.MAIL_MSG
MailModule_pb.GETALLMAILSREPLYMAILSFIELD.type = 11
MailModule_pb.GETALLMAILSREPLYMAILSFIELD.cpp_type = 10
MailModule_pb.GETALLMAILSREPLY_MSG.name = "GetAllMailsReply"
MailModule_pb.GETALLMAILSREPLY_MSG.full_name = ".GetAllMailsReply"
MailModule_pb.GETALLMAILSREPLY_MSG.nested_types = {}
MailModule_pb.GETALLMAILSREPLY_MSG.enum_types = {}
MailModule_pb.GETALLMAILSREPLY_MSG.fields = {
	MailModule_pb.GETALLMAILSREPLYMAILSFIELD
}
MailModule_pb.GETALLMAILSREPLY_MSG.is_extendable = false
MailModule_pb.GETALLMAILSREPLY_MSG.extensions = {}
MailModule_pb.MAILINCRIDFIELD.name = "incrId"
MailModule_pb.MAILINCRIDFIELD.full_name = ".Mail.incrId"
MailModule_pb.MAILINCRIDFIELD.number = 1
MailModule_pb.MAILINCRIDFIELD.index = 0
MailModule_pb.MAILINCRIDFIELD.label = 1
MailModule_pb.MAILINCRIDFIELD.has_default_value = false
MailModule_pb.MAILINCRIDFIELD.default_value = 0
MailModule_pb.MAILINCRIDFIELD.type = 4
MailModule_pb.MAILINCRIDFIELD.cpp_type = 4
MailModule_pb.MAILMAILIDFIELD.name = "mailId"
MailModule_pb.MAILMAILIDFIELD.full_name = ".Mail.mailId"
MailModule_pb.MAILMAILIDFIELD.number = 2
MailModule_pb.MAILMAILIDFIELD.index = 1
MailModule_pb.MAILMAILIDFIELD.label = 1
MailModule_pb.MAILMAILIDFIELD.has_default_value = false
MailModule_pb.MAILMAILIDFIELD.default_value = 0
MailModule_pb.MAILMAILIDFIELD.type = 13
MailModule_pb.MAILMAILIDFIELD.cpp_type = 3
MailModule_pb.MAILPARAMSFIELD.name = "params"
MailModule_pb.MAILPARAMSFIELD.full_name = ".Mail.params"
MailModule_pb.MAILPARAMSFIELD.number = 3
MailModule_pb.MAILPARAMSFIELD.index = 2
MailModule_pb.MAILPARAMSFIELD.label = 1
MailModule_pb.MAILPARAMSFIELD.has_default_value = false
MailModule_pb.MAILPARAMSFIELD.default_value = ""
MailModule_pb.MAILPARAMSFIELD.type = 9
MailModule_pb.MAILPARAMSFIELD.cpp_type = 9
MailModule_pb.MAILATTACHMENTFIELD.name = "attachment"
MailModule_pb.MAILATTACHMENTFIELD.full_name = ".Mail.attachment"
MailModule_pb.MAILATTACHMENTFIELD.number = 4
MailModule_pb.MAILATTACHMENTFIELD.index = 3
MailModule_pb.MAILATTACHMENTFIELD.label = 1
MailModule_pb.MAILATTACHMENTFIELD.has_default_value = false
MailModule_pb.MAILATTACHMENTFIELD.default_value = ""
MailModule_pb.MAILATTACHMENTFIELD.type = 9
MailModule_pb.MAILATTACHMENTFIELD.cpp_type = 9
MailModule_pb.MAILSTATEFIELD.name = "state"
MailModule_pb.MAILSTATEFIELD.full_name = ".Mail.state"
MailModule_pb.MAILSTATEFIELD.number = 5
MailModule_pb.MAILSTATEFIELD.index = 4
MailModule_pb.MAILSTATEFIELD.label = 1
MailModule_pb.MAILSTATEFIELD.has_default_value = false
MailModule_pb.MAILSTATEFIELD.default_value = 0
MailModule_pb.MAILSTATEFIELD.type = 13
MailModule_pb.MAILSTATEFIELD.cpp_type = 3
MailModule_pb.MAILCREATETIMEFIELD.name = "createTime"
MailModule_pb.MAILCREATETIMEFIELD.full_name = ".Mail.createTime"
MailModule_pb.MAILCREATETIMEFIELD.number = 6
MailModule_pb.MAILCREATETIMEFIELD.index = 5
MailModule_pb.MAILCREATETIMEFIELD.label = 1
MailModule_pb.MAILCREATETIMEFIELD.has_default_value = false
MailModule_pb.MAILCREATETIMEFIELD.default_value = 0
MailModule_pb.MAILCREATETIMEFIELD.type = 4
MailModule_pb.MAILCREATETIMEFIELD.cpp_type = 4
MailModule_pb.MAILSENDERFIELD.name = "sender"
MailModule_pb.MAILSENDERFIELD.full_name = ".Mail.sender"
MailModule_pb.MAILSENDERFIELD.number = 7
MailModule_pb.MAILSENDERFIELD.index = 6
MailModule_pb.MAILSENDERFIELD.label = 1
MailModule_pb.MAILSENDERFIELD.has_default_value = false
MailModule_pb.MAILSENDERFIELD.default_value = ""
MailModule_pb.MAILSENDERFIELD.type = 9
MailModule_pb.MAILSENDERFIELD.cpp_type = 9
MailModule_pb.MAILTITLEFIELD.name = "title"
MailModule_pb.MAILTITLEFIELD.full_name = ".Mail.title"
MailModule_pb.MAILTITLEFIELD.number = 8
MailModule_pb.MAILTITLEFIELD.index = 7
MailModule_pb.MAILTITLEFIELD.label = 1
MailModule_pb.MAILTITLEFIELD.has_default_value = false
MailModule_pb.MAILTITLEFIELD.default_value = ""
MailModule_pb.MAILTITLEFIELD.type = 9
MailModule_pb.MAILTITLEFIELD.cpp_type = 9
MailModule_pb.MAILCONTENTFIELD.name = "content"
MailModule_pb.MAILCONTENTFIELD.full_name = ".Mail.content"
MailModule_pb.MAILCONTENTFIELD.number = 9
MailModule_pb.MAILCONTENTFIELD.index = 8
MailModule_pb.MAILCONTENTFIELD.label = 1
MailModule_pb.MAILCONTENTFIELD.has_default_value = false
MailModule_pb.MAILCONTENTFIELD.default_value = ""
MailModule_pb.MAILCONTENTFIELD.type = 9
MailModule_pb.MAILCONTENTFIELD.cpp_type = 9
MailModule_pb.MAILCOPYFIELD.name = "copy"
MailModule_pb.MAILCOPYFIELD.full_name = ".Mail.copy"
MailModule_pb.MAILCOPYFIELD.number = 10
MailModule_pb.MAILCOPYFIELD.index = 9
MailModule_pb.MAILCOPYFIELD.label = 1
MailModule_pb.MAILCOPYFIELD.has_default_value = false
MailModule_pb.MAILCOPYFIELD.default_value = ""
MailModule_pb.MAILCOPYFIELD.type = 9
MailModule_pb.MAILCOPYFIELD.cpp_type = 9
MailModule_pb.MAILEXPIRETIMEFIELD.name = "expireTime"
MailModule_pb.MAILEXPIRETIMEFIELD.full_name = ".Mail.expireTime"
MailModule_pb.MAILEXPIRETIMEFIELD.number = 11
MailModule_pb.MAILEXPIRETIMEFIELD.index = 10
MailModule_pb.MAILEXPIRETIMEFIELD.label = 1
MailModule_pb.MAILEXPIRETIMEFIELD.has_default_value = false
MailModule_pb.MAILEXPIRETIMEFIELD.default_value = 0
MailModule_pb.MAILEXPIRETIMEFIELD.type = 4
MailModule_pb.MAILEXPIRETIMEFIELD.cpp_type = 4
MailModule_pb.MAILSENDERTYPEFIELD.name = "senderType"
MailModule_pb.MAILSENDERTYPEFIELD.full_name = ".Mail.senderType"
MailModule_pb.MAILSENDERTYPEFIELD.number = 12
MailModule_pb.MAILSENDERTYPEFIELD.index = 11
MailModule_pb.MAILSENDERTYPEFIELD.label = 1
MailModule_pb.MAILSENDERTYPEFIELD.has_default_value = false
MailModule_pb.MAILSENDERTYPEFIELD.default_value = 0
MailModule_pb.MAILSENDERTYPEFIELD.type = 5
MailModule_pb.MAILSENDERTYPEFIELD.cpp_type = 1
MailModule_pb.MAILJUMPTITLEFIELD.name = "jumpTitle"
MailModule_pb.MAILJUMPTITLEFIELD.full_name = ".Mail.jumpTitle"
MailModule_pb.MAILJUMPTITLEFIELD.number = 13
MailModule_pb.MAILJUMPTITLEFIELD.index = 12
MailModule_pb.MAILJUMPTITLEFIELD.label = 1
MailModule_pb.MAILJUMPTITLEFIELD.has_default_value = false
MailModule_pb.MAILJUMPTITLEFIELD.default_value = ""
MailModule_pb.MAILJUMPTITLEFIELD.type = 9
MailModule_pb.MAILJUMPTITLEFIELD.cpp_type = 9
MailModule_pb.MAILJUMPFIELD.name = "jump"
MailModule_pb.MAILJUMPFIELD.full_name = ".Mail.jump"
MailModule_pb.MAILJUMPFIELD.number = 14
MailModule_pb.MAILJUMPFIELD.index = 13
MailModule_pb.MAILJUMPFIELD.label = 1
MailModule_pb.MAILJUMPFIELD.has_default_value = false
MailModule_pb.MAILJUMPFIELD.default_value = ""
MailModule_pb.MAILJUMPFIELD.type = 9
MailModule_pb.MAILJUMPFIELD.cpp_type = 9
MailModule_pb.MAILISLOCKFIELD.name = "isLock"
MailModule_pb.MAILISLOCKFIELD.full_name = ".Mail.isLock"
MailModule_pb.MAILISLOCKFIELD.number = 15
MailModule_pb.MAILISLOCKFIELD.index = 14
MailModule_pb.MAILISLOCKFIELD.label = 1
MailModule_pb.MAILISLOCKFIELD.has_default_value = false
MailModule_pb.MAILISLOCKFIELD.default_value = false
MailModule_pb.MAILISLOCKFIELD.type = 8
MailModule_pb.MAILISLOCKFIELD.cpp_type = 7
MailModule_pb.MAIL_MSG.name = "Mail"
MailModule_pb.MAIL_MSG.full_name = ".Mail"
MailModule_pb.MAIL_MSG.nested_types = {}
MailModule_pb.MAIL_MSG.enum_types = {}
MailModule_pb.MAIL_MSG.fields = {
	MailModule_pb.MAILINCRIDFIELD,
	MailModule_pb.MAILMAILIDFIELD,
	MailModule_pb.MAILPARAMSFIELD,
	MailModule_pb.MAILATTACHMENTFIELD,
	MailModule_pb.MAILSTATEFIELD,
	MailModule_pb.MAILCREATETIMEFIELD,
	MailModule_pb.MAILSENDERFIELD,
	MailModule_pb.MAILTITLEFIELD,
	MailModule_pb.MAILCONTENTFIELD,
	MailModule_pb.MAILCOPYFIELD,
	MailModule_pb.MAILEXPIRETIMEFIELD,
	MailModule_pb.MAILSENDERTYPEFIELD,
	MailModule_pb.MAILJUMPTITLEFIELD,
	MailModule_pb.MAILJUMPFIELD,
	MailModule_pb.MAILISLOCKFIELD
}
MailModule_pb.MAIL_MSG.is_extendable = false
MailModule_pb.MAIL_MSG.extensions = {}
MailModule_pb.DELETEMAILSPUSHINCRIDSFIELD.name = "incrIds"
MailModule_pb.DELETEMAILSPUSHINCRIDSFIELD.full_name = ".DeleteMailsPush.incrIds"
MailModule_pb.DELETEMAILSPUSHINCRIDSFIELD.number = 1
MailModule_pb.DELETEMAILSPUSHINCRIDSFIELD.index = 0
MailModule_pb.DELETEMAILSPUSHINCRIDSFIELD.label = 3
MailModule_pb.DELETEMAILSPUSHINCRIDSFIELD.has_default_value = false
MailModule_pb.DELETEMAILSPUSHINCRIDSFIELD.default_value = {}
MailModule_pb.DELETEMAILSPUSHINCRIDSFIELD.type = 4
MailModule_pb.DELETEMAILSPUSHINCRIDSFIELD.cpp_type = 4
MailModule_pb.DELETEMAILSPUSH_MSG.name = "DeleteMailsPush"
MailModule_pb.DELETEMAILSPUSH_MSG.full_name = ".DeleteMailsPush"
MailModule_pb.DELETEMAILSPUSH_MSG.nested_types = {}
MailModule_pb.DELETEMAILSPUSH_MSG.enum_types = {}
MailModule_pb.DELETEMAILSPUSH_MSG.fields = {
	MailModule_pb.DELETEMAILSPUSHINCRIDSFIELD
}
MailModule_pb.DELETEMAILSPUSH_MSG.is_extendable = false
MailModule_pb.DELETEMAILSPUSH_MSG.extensions = {}
MailModule_pb.GETALLMAILSREQUEST_MSG.name = "GetAllMailsRequest"
MailModule_pb.GETALLMAILSREQUEST_MSG.full_name = ".GetAllMailsRequest"
MailModule_pb.GETALLMAILSREQUEST_MSG.nested_types = {}
MailModule_pb.GETALLMAILSREQUEST_MSG.enum_types = {}
MailModule_pb.GETALLMAILSREQUEST_MSG.fields = {}
MailModule_pb.GETALLMAILSREQUEST_MSG.is_extendable = false
MailModule_pb.GETALLMAILSREQUEST_MSG.extensions = {}
MailModule_pb.AUTOREADMAILPUSHINCRIDSFIELD.name = "incrIds"
MailModule_pb.AUTOREADMAILPUSHINCRIDSFIELD.full_name = ".AutoReadMailPush.incrIds"
MailModule_pb.AUTOREADMAILPUSHINCRIDSFIELD.number = 1
MailModule_pb.AUTOREADMAILPUSHINCRIDSFIELD.index = 0
MailModule_pb.AUTOREADMAILPUSHINCRIDSFIELD.label = 3
MailModule_pb.AUTOREADMAILPUSHINCRIDSFIELD.has_default_value = false
MailModule_pb.AUTOREADMAILPUSHINCRIDSFIELD.default_value = {}
MailModule_pb.AUTOREADMAILPUSHINCRIDSFIELD.type = 4
MailModule_pb.AUTOREADMAILPUSHINCRIDSFIELD.cpp_type = 4
MailModule_pb.AUTOREADMAILPUSH_MSG.name = "AutoReadMailPush"
MailModule_pb.AUTOREADMAILPUSH_MSG.full_name = ".AutoReadMailPush"
MailModule_pb.AUTOREADMAILPUSH_MSG.nested_types = {}
MailModule_pb.AUTOREADMAILPUSH_MSG.enum_types = {}
MailModule_pb.AUTOREADMAILPUSH_MSG.fields = {
	MailModule_pb.AUTOREADMAILPUSHINCRIDSFIELD
}
MailModule_pb.AUTOREADMAILPUSH_MSG.is_extendable = false
MailModule_pb.AUTOREADMAILPUSH_MSG.extensions = {}
MailModule_pb.READMAILBATCHREPLYINCRIDSFIELD.name = "incrIds"
MailModule_pb.READMAILBATCHREPLYINCRIDSFIELD.full_name = ".ReadMailBatchReply.incrIds"
MailModule_pb.READMAILBATCHREPLYINCRIDSFIELD.number = 1
MailModule_pb.READMAILBATCHREPLYINCRIDSFIELD.index = 0
MailModule_pb.READMAILBATCHREPLYINCRIDSFIELD.label = 3
MailModule_pb.READMAILBATCHREPLYINCRIDSFIELD.has_default_value = false
MailModule_pb.READMAILBATCHREPLYINCRIDSFIELD.default_value = {}
MailModule_pb.READMAILBATCHREPLYINCRIDSFIELD.type = 4
MailModule_pb.READMAILBATCHREPLYINCRIDSFIELD.cpp_type = 4
MailModule_pb.READMAILBATCHREPLY_MSG.name = "ReadMailBatchReply"
MailModule_pb.READMAILBATCHREPLY_MSG.full_name = ".ReadMailBatchReply"
MailModule_pb.READMAILBATCHREPLY_MSG.nested_types = {}
MailModule_pb.READMAILBATCHREPLY_MSG.enum_types = {}
MailModule_pb.READMAILBATCHREPLY_MSG.fields = {
	MailModule_pb.READMAILBATCHREPLYINCRIDSFIELD
}
MailModule_pb.READMAILBATCHREPLY_MSG.is_extendable = false
MailModule_pb.READMAILBATCHREPLY_MSG.extensions = {}
MailModule_pb.MAILLOCKREQUESTINCRIDFIELD.name = "incrId"
MailModule_pb.MAILLOCKREQUESTINCRIDFIELD.full_name = ".MailLockRequest.incrId"
MailModule_pb.MAILLOCKREQUESTINCRIDFIELD.number = 1
MailModule_pb.MAILLOCKREQUESTINCRIDFIELD.index = 0
MailModule_pb.MAILLOCKREQUESTINCRIDFIELD.label = 1
MailModule_pb.MAILLOCKREQUESTINCRIDFIELD.has_default_value = false
MailModule_pb.MAILLOCKREQUESTINCRIDFIELD.default_value = 0
MailModule_pb.MAILLOCKREQUESTINCRIDFIELD.type = 4
MailModule_pb.MAILLOCKREQUESTINCRIDFIELD.cpp_type = 4
MailModule_pb.MAILLOCKREQUESTLOCKFIELD.name = "lock"
MailModule_pb.MAILLOCKREQUESTLOCKFIELD.full_name = ".MailLockRequest.lock"
MailModule_pb.MAILLOCKREQUESTLOCKFIELD.number = 2
MailModule_pb.MAILLOCKREQUESTLOCKFIELD.index = 1
MailModule_pb.MAILLOCKREQUESTLOCKFIELD.label = 1
MailModule_pb.MAILLOCKREQUESTLOCKFIELD.has_default_value = false
MailModule_pb.MAILLOCKREQUESTLOCKFIELD.default_value = false
MailModule_pb.MAILLOCKREQUESTLOCKFIELD.type = 8
MailModule_pb.MAILLOCKREQUESTLOCKFIELD.cpp_type = 7
MailModule_pb.MAILLOCKREQUEST_MSG.name = "MailLockRequest"
MailModule_pb.MAILLOCKREQUEST_MSG.full_name = ".MailLockRequest"
MailModule_pb.MAILLOCKREQUEST_MSG.nested_types = {}
MailModule_pb.MAILLOCKREQUEST_MSG.enum_types = {}
MailModule_pb.MAILLOCKREQUEST_MSG.fields = {
	MailModule_pb.MAILLOCKREQUESTINCRIDFIELD,
	MailModule_pb.MAILLOCKREQUESTLOCKFIELD
}
MailModule_pb.MAILLOCKREQUEST_MSG.is_extendable = false
MailModule_pb.MAILLOCKREQUEST_MSG.extensions = {}
MailModule_pb.AutoReadMailPush = protobuf.Message(MailModule_pb.AUTOREADMAILPUSH_MSG)
MailModule_pb.DeleteMailBatchReply = protobuf.Message(MailModule_pb.DELETEMAILBATCHREPLY_MSG)
MailModule_pb.DeleteMailBatchRequest = protobuf.Message(MailModule_pb.DELETEMAILBATCHREQUEST_MSG)
MailModule_pb.DeleteMailsPush = protobuf.Message(MailModule_pb.DELETEMAILSPUSH_MSG)
MailModule_pb.GetAllMailsReply = protobuf.Message(MailModule_pb.GETALLMAILSREPLY_MSG)
MailModule_pb.GetAllMailsRequest = protobuf.Message(MailModule_pb.GETALLMAILSREQUEST_MSG)
MailModule_pb.Mail = protobuf.Message(MailModule_pb.MAIL_MSG)
MailModule_pb.MailLockReply = protobuf.Message(MailModule_pb.MAILLOCKREPLY_MSG)
MailModule_pb.MailLockRequest = protobuf.Message(MailModule_pb.MAILLOCKREQUEST_MSG)
MailModule_pb.MarkMailJumpReply = protobuf.Message(MailModule_pb.MARKMAILJUMPREPLY_MSG)
MailModule_pb.MarkMailJumpRequest = protobuf.Message(MailModule_pb.MARKMAILJUMPREQUEST_MSG)
MailModule_pb.NewMailPush = protobuf.Message(MailModule_pb.NEWMAILPUSH_MSG)
MailModule_pb.ReadMailBatchReply = protobuf.Message(MailModule_pb.READMAILBATCHREPLY_MSG)
MailModule_pb.ReadMailBatchRequest = protobuf.Message(MailModule_pb.READMAILBATCHREQUEST_MSG)
MailModule_pb.ReadMailReply = protobuf.Message(MailModule_pb.READMAILREPLY_MSG)
MailModule_pb.ReadMailRequest = protobuf.Message(MailModule_pb.READMAILREQUEST_MSG)

return MailModule_pb
