-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/TextDetectExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.TextDetectExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.CheckDescriptionRequest = protobuf.Descriptor()
field_descriptors.CheckDescriptionRequest_description = protobuf.FieldDescriptor()
type_descriptors.GenerateImageUploadingTokenReply = protobuf.Descriptor()
field_descriptors.GenerateImageUploadingTokenReply_token = protobuf.FieldDescriptor()
field_descriptors.GenerateImageUploadingTokenReply_bucket = protobuf.FieldDescriptor()
type_descriptors.CheckDescriptionReply = protobuf.Descriptor()
field_descriptors.CheckDescriptionReply_description = protobuf.FieldDescriptor()
type_descriptors.DescriptionNO = protobuf.Descriptor()
field_descriptors.DescriptionNO_type = protobuf.FieldDescriptor()
field_descriptors.DescriptionNO_id = protobuf.FieldDescriptor()
field_descriptors.DescriptionNO_descriptionHash = protobuf.FieldDescriptor()
field_descriptors.DescriptionNO_description = protobuf.FieldDescriptor()
type_descriptors.GenerateImageUploadingTokenRequest = protobuf.Descriptor()
field_descriptors.CheckDescriptionRequest_description.name = "description"
field_descriptors.CheckDescriptionRequest_description.full_name = ".CheckDescriptionRequest.description"
field_descriptors.CheckDescriptionRequest_description.number = 1
field_descriptors.CheckDescriptionRequest_description.index = 0
field_descriptors.CheckDescriptionRequest_description.label = 3
field_descriptors.CheckDescriptionRequest_description.has_default_value = false
field_descriptors.CheckDescriptionRequest_description.default_value = {}
field_descriptors.CheckDescriptionRequest_description.message_type = type_descriptors.DescriptionNO
field_descriptors.CheckDescriptionRequest_description.type = 11
field_descriptors.CheckDescriptionRequest_description.cpp_type = 10
type_descriptors.CheckDescriptionRequest.name = "CheckDescriptionRequest"
type_descriptors.CheckDescriptionRequest.full_name = ".CheckDescriptionRequest"
type_descriptors.CheckDescriptionRequest.nested_types = {}
type_descriptors.CheckDescriptionRequest.enum_types = {}
type_descriptors.CheckDescriptionRequest.fields = {
	field_descriptors.CheckDescriptionRequest_description
}
type_descriptors.CheckDescriptionRequest.is_extendable = false
type_descriptors.CheckDescriptionRequest.extensions = {}
field_descriptors.GenerateImageUploadingTokenReply_token.name = "token"
field_descriptors.GenerateImageUploadingTokenReply_token.full_name = ".GenerateImageUploadingTokenReply.token"
field_descriptors.GenerateImageUploadingTokenReply_token.number = 1
field_descriptors.GenerateImageUploadingTokenReply_token.index = 0
field_descriptors.GenerateImageUploadingTokenReply_token.label = 1
field_descriptors.GenerateImageUploadingTokenReply_token.has_default_value = false
field_descriptors.GenerateImageUploadingTokenReply_token.default_value = ""
field_descriptors.GenerateImageUploadingTokenReply_token.type = 9
field_descriptors.GenerateImageUploadingTokenReply_token.cpp_type = 9
field_descriptors.GenerateImageUploadingTokenReply_bucket.name = "bucket"
field_descriptors.GenerateImageUploadingTokenReply_bucket.full_name = ".GenerateImageUploadingTokenReply.bucket"
field_descriptors.GenerateImageUploadingTokenReply_bucket.number = 2
field_descriptors.GenerateImageUploadingTokenReply_bucket.index = 1
field_descriptors.GenerateImageUploadingTokenReply_bucket.label = 1
field_descriptors.GenerateImageUploadingTokenReply_bucket.has_default_value = false
field_descriptors.GenerateImageUploadingTokenReply_bucket.default_value = ""
field_descriptors.GenerateImageUploadingTokenReply_bucket.type = 9
field_descriptors.GenerateImageUploadingTokenReply_bucket.cpp_type = 9
type_descriptors.GenerateImageUploadingTokenReply.name = "GenerateImageUploadingTokenReply"
type_descriptors.GenerateImageUploadingTokenReply.full_name = ".GenerateImageUploadingTokenReply"
type_descriptors.GenerateImageUploadingTokenReply.nested_types = {}
type_descriptors.GenerateImageUploadingTokenReply.enum_types = {}
type_descriptors.GenerateImageUploadingTokenReply.fields = {
	field_descriptors.GenerateImageUploadingTokenReply_token,
	field_descriptors.GenerateImageUploadingTokenReply_bucket
}
type_descriptors.GenerateImageUploadingTokenReply.is_extendable = false
type_descriptors.GenerateImageUploadingTokenReply.extensions = {}
field_descriptors.CheckDescriptionReply_description.name = "description"
field_descriptors.CheckDescriptionReply_description.full_name = ".CheckDescriptionReply.description"
field_descriptors.CheckDescriptionReply_description.number = 1
field_descriptors.CheckDescriptionReply_description.index = 0
field_descriptors.CheckDescriptionReply_description.label = 3
field_descriptors.CheckDescriptionReply_description.has_default_value = false
field_descriptors.CheckDescriptionReply_description.default_value = {}
field_descriptors.CheckDescriptionReply_description.message_type = type_descriptors.DescriptionNO
field_descriptors.CheckDescriptionReply_description.type = 11
field_descriptors.CheckDescriptionReply_description.cpp_type = 10
type_descriptors.CheckDescriptionReply.name = "CheckDescriptionReply"
type_descriptors.CheckDescriptionReply.full_name = ".CheckDescriptionReply"
type_descriptors.CheckDescriptionReply.nested_types = {}
type_descriptors.CheckDescriptionReply.enum_types = {}
type_descriptors.CheckDescriptionReply.fields = {
	field_descriptors.CheckDescriptionReply_description
}
type_descriptors.CheckDescriptionReply.is_extendable = false
type_descriptors.CheckDescriptionReply.extensions = {}
field_descriptors.DescriptionNO_type.name = "type"
field_descriptors.DescriptionNO_type.full_name = ".DescriptionNO.type"
field_descriptors.DescriptionNO_type.number = 1
field_descriptors.DescriptionNO_type.index = 0
field_descriptors.DescriptionNO_type.label = 2
field_descriptors.DescriptionNO_type.has_default_value = false
field_descriptors.DescriptionNO_type.default_value = 0
field_descriptors.DescriptionNO_type.type = 5
field_descriptors.DescriptionNO_type.cpp_type = 1
field_descriptors.DescriptionNO_id.name = "id"
field_descriptors.DescriptionNO_id.full_name = ".DescriptionNO.id"
field_descriptors.DescriptionNO_id.number = 2
field_descriptors.DescriptionNO_id.index = 1
field_descriptors.DescriptionNO_id.label = 2
field_descriptors.DescriptionNO_id.has_default_value = false
field_descriptors.DescriptionNO_id.default_value = ""
field_descriptors.DescriptionNO_id.type = 9
field_descriptors.DescriptionNO_id.cpp_type = 9
field_descriptors.DescriptionNO_descriptionHash.name = "descriptionHash"
field_descriptors.DescriptionNO_descriptionHash.full_name = ".DescriptionNO.descriptionHash"
field_descriptors.DescriptionNO_descriptionHash.number = 3
field_descriptors.DescriptionNO_descriptionHash.index = 2
field_descriptors.DescriptionNO_descriptionHash.label = 1
field_descriptors.DescriptionNO_descriptionHash.has_default_value = false
field_descriptors.DescriptionNO_descriptionHash.default_value = 0
field_descriptors.DescriptionNO_descriptionHash.type = 5
field_descriptors.DescriptionNO_descriptionHash.cpp_type = 1
field_descriptors.DescriptionNO_description.name = "description"
field_descriptors.DescriptionNO_description.full_name = ".DescriptionNO.description"
field_descriptors.DescriptionNO_description.number = 4
field_descriptors.DescriptionNO_description.index = 3
field_descriptors.DescriptionNO_description.label = 1
field_descriptors.DescriptionNO_description.has_default_value = false
field_descriptors.DescriptionNO_description.default_value = ""
field_descriptors.DescriptionNO_description.type = 9
field_descriptors.DescriptionNO_description.cpp_type = 9
type_descriptors.DescriptionNO.name = "DescriptionNO"
type_descriptors.DescriptionNO.full_name = ".DescriptionNO"
type_descriptors.DescriptionNO.nested_types = {}
type_descriptors.DescriptionNO.enum_types = {}
type_descriptors.DescriptionNO.fields = {
	field_descriptors.DescriptionNO_type,
	field_descriptors.DescriptionNO_id,
	field_descriptors.DescriptionNO_descriptionHash,
	field_descriptors.DescriptionNO_description
}
type_descriptors.DescriptionNO.is_extendable = false
type_descriptors.DescriptionNO.extensions = {}
type_descriptors.GenerateImageUploadingTokenRequest.name = "GenerateImageUploadingTokenRequest"
type_descriptors.GenerateImageUploadingTokenRequest.full_name = ".GenerateImageUploadingTokenRequest"
type_descriptors.GenerateImageUploadingTokenRequest.nested_types = {}
type_descriptors.GenerateImageUploadingTokenRequest.enum_types = {}
type_descriptors.GenerateImageUploadingTokenRequest.fields = {}
type_descriptors.GenerateImageUploadingTokenRequest.is_extendable = false
type_descriptors.GenerateImageUploadingTokenRequest.extensions = {}
CheckDescriptionReply = protobuf.Message(type_descriptors.CheckDescriptionReply)
CheckDescriptionRequest = protobuf.Message(type_descriptors.CheckDescriptionRequest)
DescriptionNO = protobuf.Message(type_descriptors.DescriptionNO)
GenerateImageUploadingTokenReply = protobuf.Message(type_descriptors.GenerateImageUploadingTokenReply)
GenerateImageUploadingTokenRequest = protobuf.Message(type_descriptors.GenerateImageUploadingTokenRequest)

return _G["logic.proto.TextDetectExtension_pb"]
