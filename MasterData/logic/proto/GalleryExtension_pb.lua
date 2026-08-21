-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/GalleryExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.GalleryExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.GetMonsterCommentReply = protobuf.Descriptor()
field_descriptors.GetMonsterCommentReply_star = protobuf.FieldDescriptor()
field_descriptors.GetMonsterCommentReply_count = protobuf.FieldDescriptor()
field_descriptors.GetMonsterCommentReply_tag = protobuf.FieldDescriptor()
field_descriptors.GetMonsterCommentReply_myStar = protobuf.FieldDescriptor()
field_descriptors.GetMonsterCommentReply_myTag = protobuf.FieldDescriptor()
type_descriptors.CommitMonsterCommentRequest = protobuf.Descriptor()
field_descriptors.CommitMonsterCommentRequest_monsterId = protobuf.FieldDescriptor()
field_descriptors.CommitMonsterCommentRequest_star = protobuf.FieldDescriptor()
field_descriptors.CommitMonsterCommentRequest_tagId = protobuf.FieldDescriptor()
type_descriptors.UnlockPlotMemoryReply = protobuf.Descriptor()
field_descriptors.UnlockPlotMemoryReply_id = protobuf.FieldDescriptor()
type_descriptors.GetMonsterCommentRequest = protobuf.Descriptor()
field_descriptors.GetMonsterCommentRequest_monsterId = protobuf.FieldDescriptor()
type_descriptors.CommitMonsterCommentReply = protobuf.Descriptor()
type_descriptors.UnlockPlotMemoryRequest = protobuf.Descriptor()
field_descriptors.UnlockPlotMemoryRequest_id = protobuf.FieldDescriptor()
type_descriptors.CommentTagNO = protobuf.Descriptor()
field_descriptors.CommentTagNO_id = protobuf.FieldDescriptor()
field_descriptors.CommentTagNO_count = protobuf.FieldDescriptor()
field_descriptors.GetMonsterCommentReply_star.name = "star"
field_descriptors.GetMonsterCommentReply_star.full_name = ".GetMonsterCommentReply.star"
field_descriptors.GetMonsterCommentReply_star.number = 1
field_descriptors.GetMonsterCommentReply_star.index = 0
field_descriptors.GetMonsterCommentReply_star.label = 2
field_descriptors.GetMonsterCommentReply_star.has_default_value = false
field_descriptors.GetMonsterCommentReply_star.default_value = 0
field_descriptors.GetMonsterCommentReply_star.type = 5
field_descriptors.GetMonsterCommentReply_star.cpp_type = 1
field_descriptors.GetMonsterCommentReply_count.name = "count"
field_descriptors.GetMonsterCommentReply_count.full_name = ".GetMonsterCommentReply.count"
field_descriptors.GetMonsterCommentReply_count.number = 2
field_descriptors.GetMonsterCommentReply_count.index = 1
field_descriptors.GetMonsterCommentReply_count.label = 2
field_descriptors.GetMonsterCommentReply_count.has_default_value = false
field_descriptors.GetMonsterCommentReply_count.default_value = 0
field_descriptors.GetMonsterCommentReply_count.type = 5
field_descriptors.GetMonsterCommentReply_count.cpp_type = 1
field_descriptors.GetMonsterCommentReply_tag.name = "tag"
field_descriptors.GetMonsterCommentReply_tag.full_name = ".GetMonsterCommentReply.tag"
field_descriptors.GetMonsterCommentReply_tag.number = 3
field_descriptors.GetMonsterCommentReply_tag.index = 2
field_descriptors.GetMonsterCommentReply_tag.label = 3
field_descriptors.GetMonsterCommentReply_tag.has_default_value = false
field_descriptors.GetMonsterCommentReply_tag.default_value = {}
field_descriptors.GetMonsterCommentReply_tag.message_type = type_descriptors.CommentTagNO
field_descriptors.GetMonsterCommentReply_tag.type = 11
field_descriptors.GetMonsterCommentReply_tag.cpp_type = 10
field_descriptors.GetMonsterCommentReply_myStar.name = "myStar"
field_descriptors.GetMonsterCommentReply_myStar.full_name = ".GetMonsterCommentReply.myStar"
field_descriptors.GetMonsterCommentReply_myStar.number = 4
field_descriptors.GetMonsterCommentReply_myStar.index = 3
field_descriptors.GetMonsterCommentReply_myStar.label = 1
field_descriptors.GetMonsterCommentReply_myStar.has_default_value = false
field_descriptors.GetMonsterCommentReply_myStar.default_value = 0
field_descriptors.GetMonsterCommentReply_myStar.type = 5
field_descriptors.GetMonsterCommentReply_myStar.cpp_type = 1
field_descriptors.GetMonsterCommentReply_myTag.name = "myTag"
field_descriptors.GetMonsterCommentReply_myTag.full_name = ".GetMonsterCommentReply.myTag"
field_descriptors.GetMonsterCommentReply_myTag.number = 5
field_descriptors.GetMonsterCommentReply_myTag.index = 4
field_descriptors.GetMonsterCommentReply_myTag.label = 3
field_descriptors.GetMonsterCommentReply_myTag.has_default_value = false
field_descriptors.GetMonsterCommentReply_myTag.default_value = {}
field_descriptors.GetMonsterCommentReply_myTag.type = 5
field_descriptors.GetMonsterCommentReply_myTag.cpp_type = 1
type_descriptors.GetMonsterCommentReply.name = "GetMonsterCommentReply"
type_descriptors.GetMonsterCommentReply.full_name = ".GetMonsterCommentReply"
type_descriptors.GetMonsterCommentReply.nested_types = {}
type_descriptors.GetMonsterCommentReply.enum_types = {}
type_descriptors.GetMonsterCommentReply.fields = {
	field_descriptors.GetMonsterCommentReply_star,
	field_descriptors.GetMonsterCommentReply_count,
	field_descriptors.GetMonsterCommentReply_tag,
	field_descriptors.GetMonsterCommentReply_myStar,
	field_descriptors.GetMonsterCommentReply_myTag
}
type_descriptors.GetMonsterCommentReply.is_extendable = false
type_descriptors.GetMonsterCommentReply.extensions = {}
field_descriptors.CommitMonsterCommentRequest_monsterId.name = "monsterId"
field_descriptors.CommitMonsterCommentRequest_monsterId.full_name = ".CommitMonsterCommentRequest.monsterId"
field_descriptors.CommitMonsterCommentRequest_monsterId.number = 1
field_descriptors.CommitMonsterCommentRequest_monsterId.index = 0
field_descriptors.CommitMonsterCommentRequest_monsterId.label = 2
field_descriptors.CommitMonsterCommentRequest_monsterId.has_default_value = false
field_descriptors.CommitMonsterCommentRequest_monsterId.default_value = 0
field_descriptors.CommitMonsterCommentRequest_monsterId.type = 5
field_descriptors.CommitMonsterCommentRequest_monsterId.cpp_type = 1
field_descriptors.CommitMonsterCommentRequest_star.name = "star"
field_descriptors.CommitMonsterCommentRequest_star.full_name = ".CommitMonsterCommentRequest.star"
field_descriptors.CommitMonsterCommentRequest_star.number = 2
field_descriptors.CommitMonsterCommentRequest_star.index = 1
field_descriptors.CommitMonsterCommentRequest_star.label = 2
field_descriptors.CommitMonsterCommentRequest_star.has_default_value = false
field_descriptors.CommitMonsterCommentRequest_star.default_value = 0
field_descriptors.CommitMonsterCommentRequest_star.type = 5
field_descriptors.CommitMonsterCommentRequest_star.cpp_type = 1
field_descriptors.CommitMonsterCommentRequest_tagId.name = "tagId"
field_descriptors.CommitMonsterCommentRequest_tagId.full_name = ".CommitMonsterCommentRequest.tagId"
field_descriptors.CommitMonsterCommentRequest_tagId.number = 3
field_descriptors.CommitMonsterCommentRequest_tagId.index = 2
field_descriptors.CommitMonsterCommentRequest_tagId.label = 3
field_descriptors.CommitMonsterCommentRequest_tagId.has_default_value = false
field_descriptors.CommitMonsterCommentRequest_tagId.default_value = {}
field_descriptors.CommitMonsterCommentRequest_tagId.type = 5
field_descriptors.CommitMonsterCommentRequest_tagId.cpp_type = 1
type_descriptors.CommitMonsterCommentRequest.name = "CommitMonsterCommentRequest"
type_descriptors.CommitMonsterCommentRequest.full_name = ".CommitMonsterCommentRequest"
type_descriptors.CommitMonsterCommentRequest.nested_types = {}
type_descriptors.CommitMonsterCommentRequest.enum_types = {}
type_descriptors.CommitMonsterCommentRequest.fields = {
	field_descriptors.CommitMonsterCommentRequest_monsterId,
	field_descriptors.CommitMonsterCommentRequest_star,
	field_descriptors.CommitMonsterCommentRequest_tagId
}
type_descriptors.CommitMonsterCommentRequest.is_extendable = false
type_descriptors.CommitMonsterCommentRequest.extensions = {}
field_descriptors.UnlockPlotMemoryReply_id.name = "id"
field_descriptors.UnlockPlotMemoryReply_id.full_name = ".UnlockPlotMemoryReply.id"
field_descriptors.UnlockPlotMemoryReply_id.number = 1
field_descriptors.UnlockPlotMemoryReply_id.index = 0
field_descriptors.UnlockPlotMemoryReply_id.label = 3
field_descriptors.UnlockPlotMemoryReply_id.has_default_value = false
field_descriptors.UnlockPlotMemoryReply_id.default_value = {}
field_descriptors.UnlockPlotMemoryReply_id.type = 5
field_descriptors.UnlockPlotMemoryReply_id.cpp_type = 1
type_descriptors.UnlockPlotMemoryReply.name = "UnlockPlotMemoryReply"
type_descriptors.UnlockPlotMemoryReply.full_name = ".UnlockPlotMemoryReply"
type_descriptors.UnlockPlotMemoryReply.nested_types = {}
type_descriptors.UnlockPlotMemoryReply.enum_types = {}
type_descriptors.UnlockPlotMemoryReply.fields = {
	field_descriptors.UnlockPlotMemoryReply_id
}
type_descriptors.UnlockPlotMemoryReply.is_extendable = false
type_descriptors.UnlockPlotMemoryReply.extensions = {}
field_descriptors.GetMonsterCommentRequest_monsterId.name = "monsterId"
field_descriptors.GetMonsterCommentRequest_monsterId.full_name = ".GetMonsterCommentRequest.monsterId"
field_descriptors.GetMonsterCommentRequest_monsterId.number = 1
field_descriptors.GetMonsterCommentRequest_monsterId.index = 0
field_descriptors.GetMonsterCommentRequest_monsterId.label = 2
field_descriptors.GetMonsterCommentRequest_monsterId.has_default_value = false
field_descriptors.GetMonsterCommentRequest_monsterId.default_value = 0
field_descriptors.GetMonsterCommentRequest_monsterId.type = 5
field_descriptors.GetMonsterCommentRequest_monsterId.cpp_type = 1
type_descriptors.GetMonsterCommentRequest.name = "GetMonsterCommentRequest"
type_descriptors.GetMonsterCommentRequest.full_name = ".GetMonsterCommentRequest"
type_descriptors.GetMonsterCommentRequest.nested_types = {}
type_descriptors.GetMonsterCommentRequest.enum_types = {}
type_descriptors.GetMonsterCommentRequest.fields = {
	field_descriptors.GetMonsterCommentRequest_monsterId
}
type_descriptors.GetMonsterCommentRequest.is_extendable = false
type_descriptors.GetMonsterCommentRequest.extensions = {}
type_descriptors.CommitMonsterCommentReply.name = "CommitMonsterCommentReply"
type_descriptors.CommitMonsterCommentReply.full_name = ".CommitMonsterCommentReply"
type_descriptors.CommitMonsterCommentReply.nested_types = {}
type_descriptors.CommitMonsterCommentReply.enum_types = {}
type_descriptors.CommitMonsterCommentReply.fields = {}
type_descriptors.CommitMonsterCommentReply.is_extendable = false
type_descriptors.CommitMonsterCommentReply.extensions = {}
field_descriptors.UnlockPlotMemoryRequest_id.name = "id"
field_descriptors.UnlockPlotMemoryRequest_id.full_name = ".UnlockPlotMemoryRequest.id"
field_descriptors.UnlockPlotMemoryRequest_id.number = 1
field_descriptors.UnlockPlotMemoryRequest_id.index = 0
field_descriptors.UnlockPlotMemoryRequest_id.label = 3
field_descriptors.UnlockPlotMemoryRequest_id.has_default_value = false
field_descriptors.UnlockPlotMemoryRequest_id.default_value = {}
field_descriptors.UnlockPlotMemoryRequest_id.type = 5
field_descriptors.UnlockPlotMemoryRequest_id.cpp_type = 1
type_descriptors.UnlockPlotMemoryRequest.name = "UnlockPlotMemoryRequest"
type_descriptors.UnlockPlotMemoryRequest.full_name = ".UnlockPlotMemoryRequest"
type_descriptors.UnlockPlotMemoryRequest.nested_types = {}
type_descriptors.UnlockPlotMemoryRequest.enum_types = {}
type_descriptors.UnlockPlotMemoryRequest.fields = {
	field_descriptors.UnlockPlotMemoryRequest_id
}
type_descriptors.UnlockPlotMemoryRequest.is_extendable = false
type_descriptors.UnlockPlotMemoryRequest.extensions = {}
field_descriptors.CommentTagNO_id.name = "id"
field_descriptors.CommentTagNO_id.full_name = ".CommentTagNO.id"
field_descriptors.CommentTagNO_id.number = 1
field_descriptors.CommentTagNO_id.index = 0
field_descriptors.CommentTagNO_id.label = 2
field_descriptors.CommentTagNO_id.has_default_value = false
field_descriptors.CommentTagNO_id.default_value = 0
field_descriptors.CommentTagNO_id.type = 5
field_descriptors.CommentTagNO_id.cpp_type = 1
field_descriptors.CommentTagNO_count.name = "count"
field_descriptors.CommentTagNO_count.full_name = ".CommentTagNO.count"
field_descriptors.CommentTagNO_count.number = 2
field_descriptors.CommentTagNO_count.index = 1
field_descriptors.CommentTagNO_count.label = 2
field_descriptors.CommentTagNO_count.has_default_value = false
field_descriptors.CommentTagNO_count.default_value = 0
field_descriptors.CommentTagNO_count.type = 5
field_descriptors.CommentTagNO_count.cpp_type = 1
type_descriptors.CommentTagNO.name = "CommentTagNO"
type_descriptors.CommentTagNO.full_name = ".CommentTagNO"
type_descriptors.CommentTagNO.nested_types = {}
type_descriptors.CommentTagNO.enum_types = {}
type_descriptors.CommentTagNO.fields = {
	field_descriptors.CommentTagNO_id,
	field_descriptors.CommentTagNO_count
}
type_descriptors.CommentTagNO.is_extendable = false
type_descriptors.CommentTagNO.extensions = {}
CommentTagNO = protobuf.Message(type_descriptors.CommentTagNO)
CommitMonsterCommentReply = protobuf.Message(type_descriptors.CommitMonsterCommentReply)
CommitMonsterCommentRequest = protobuf.Message(type_descriptors.CommitMonsterCommentRequest)
GetMonsterCommentReply = protobuf.Message(type_descriptors.GetMonsterCommentReply)
GetMonsterCommentRequest = protobuf.Message(type_descriptors.GetMonsterCommentRequest)
UnlockPlotMemoryReply = protobuf.Message(type_descriptors.UnlockPlotMemoryReply)
UnlockPlotMemoryRequest = protobuf.Message(type_descriptors.UnlockPlotMemoryRequest)

return _G["logic.proto.GalleryExtension_pb"]
