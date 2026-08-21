-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/TeamEditExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.TeamEditExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.TeamCell = protobuf.Descriptor()
field_descriptors.TeamCell_gid = protobuf.FieldDescriptor()
field_descriptors.TeamCell_uuid = protobuf.FieldDescriptor()
type_descriptors.TeamsInfoReply = protobuf.Descriptor()
field_descriptors.TeamsInfoReply_teams = protobuf.FieldDescriptor()
type_descriptors.EditTeamNameRequest = protobuf.Descriptor()
field_descriptors.EditTeamNameRequest_tid = protobuf.FieldDescriptor()
field_descriptors.EditTeamNameRequest_name = protobuf.FieldDescriptor()
type_descriptors.SaveTeamRoleRequest = protobuf.Descriptor()
field_descriptors.SaveTeamRoleRequest_team = protobuf.FieldDescriptor()
type_descriptors.DeleteTeamReply = protobuf.Descriptor()
field_descriptors.DeleteTeamReply_tid = protobuf.FieldDescriptor()
type_descriptors.Team = protobuf.Descriptor()
field_descriptors.Team_tid = protobuf.FieldDescriptor()
field_descriptors.Team_teamName = protobuf.FieldDescriptor()
field_descriptors.Team_lastModifyTime = protobuf.FieldDescriptor()
field_descriptors.Team_roles = protobuf.FieldDescriptor()
type_descriptors.DeleteTeamRequest = protobuf.Descriptor()
field_descriptors.DeleteTeamRequest_tid = protobuf.FieldDescriptor()
type_descriptors.LoadTeamsRequest = protobuf.Descriptor()
field_descriptors.TeamCell_gid.name = "gid"
field_descriptors.TeamCell_gid.full_name = ".TeamCell.gid"
field_descriptors.TeamCell_gid.number = 1
field_descriptors.TeamCell_gid.index = 0
field_descriptors.TeamCell_gid.label = 1
field_descriptors.TeamCell_gid.has_default_value = false
field_descriptors.TeamCell_gid.default_value = 0
field_descriptors.TeamCell_gid.type = 5
field_descriptors.TeamCell_gid.cpp_type = 1
field_descriptors.TeamCell_uuid.name = "uuid"
field_descriptors.TeamCell_uuid.full_name = ".TeamCell.uuid"
field_descriptors.TeamCell_uuid.number = 2
field_descriptors.TeamCell_uuid.index = 1
field_descriptors.TeamCell_uuid.label = 1
field_descriptors.TeamCell_uuid.has_default_value = false
field_descriptors.TeamCell_uuid.default_value = 0
field_descriptors.TeamCell_uuid.type = 5
field_descriptors.TeamCell_uuid.cpp_type = 1
type_descriptors.TeamCell.name = "TeamCell"
type_descriptors.TeamCell.full_name = ".TeamCell"
type_descriptors.TeamCell.nested_types = {}
type_descriptors.TeamCell.enum_types = {}
type_descriptors.TeamCell.fields = {
	field_descriptors.TeamCell_gid,
	field_descriptors.TeamCell_uuid
}
type_descriptors.TeamCell.is_extendable = false
type_descriptors.TeamCell.extensions = {}
field_descriptors.TeamsInfoReply_teams.name = "teams"
field_descriptors.TeamsInfoReply_teams.full_name = ".TeamsInfoReply.teams"
field_descriptors.TeamsInfoReply_teams.number = 1
field_descriptors.TeamsInfoReply_teams.index = 0
field_descriptors.TeamsInfoReply_teams.label = 3
field_descriptors.TeamsInfoReply_teams.has_default_value = false
field_descriptors.TeamsInfoReply_teams.default_value = {}
field_descriptors.TeamsInfoReply_teams.message_type = type_descriptors.Team
field_descriptors.TeamsInfoReply_teams.type = 11
field_descriptors.TeamsInfoReply_teams.cpp_type = 10
type_descriptors.TeamsInfoReply.name = "TeamsInfoReply"
type_descriptors.TeamsInfoReply.full_name = ".TeamsInfoReply"
type_descriptors.TeamsInfoReply.nested_types = {}
type_descriptors.TeamsInfoReply.enum_types = {}
type_descriptors.TeamsInfoReply.fields = {
	field_descriptors.TeamsInfoReply_teams
}
type_descriptors.TeamsInfoReply.is_extendable = false
type_descriptors.TeamsInfoReply.extensions = {}
field_descriptors.EditTeamNameRequest_tid.name = "tid"
field_descriptors.EditTeamNameRequest_tid.full_name = ".EditTeamNameRequest.tid"
field_descriptors.EditTeamNameRequest_tid.number = 1
field_descriptors.EditTeamNameRequest_tid.index = 0
field_descriptors.EditTeamNameRequest_tid.label = 1
field_descriptors.EditTeamNameRequest_tid.has_default_value = false
field_descriptors.EditTeamNameRequest_tid.default_value = 0
field_descriptors.EditTeamNameRequest_tid.type = 5
field_descriptors.EditTeamNameRequest_tid.cpp_type = 1
field_descriptors.EditTeamNameRequest_name.name = "name"
field_descriptors.EditTeamNameRequest_name.full_name = ".EditTeamNameRequest.name"
field_descriptors.EditTeamNameRequest_name.number = 2
field_descriptors.EditTeamNameRequest_name.index = 1
field_descriptors.EditTeamNameRequest_name.label = 1
field_descriptors.EditTeamNameRequest_name.has_default_value = false
field_descriptors.EditTeamNameRequest_name.default_value = ""
field_descriptors.EditTeamNameRequest_name.type = 9
field_descriptors.EditTeamNameRequest_name.cpp_type = 9
type_descriptors.EditTeamNameRequest.name = "EditTeamNameRequest"
type_descriptors.EditTeamNameRequest.full_name = ".EditTeamNameRequest"
type_descriptors.EditTeamNameRequest.nested_types = {}
type_descriptors.EditTeamNameRequest.enum_types = {}
type_descriptors.EditTeamNameRequest.fields = {
	field_descriptors.EditTeamNameRequest_tid,
	field_descriptors.EditTeamNameRequest_name
}
type_descriptors.EditTeamNameRequest.is_extendable = false
type_descriptors.EditTeamNameRequest.extensions = {}
field_descriptors.SaveTeamRoleRequest_team.name = "team"
field_descriptors.SaveTeamRoleRequest_team.full_name = ".SaveTeamRoleRequest.team"
field_descriptors.SaveTeamRoleRequest_team.number = 1
field_descriptors.SaveTeamRoleRequest_team.index = 0
field_descriptors.SaveTeamRoleRequest_team.label = 1
field_descriptors.SaveTeamRoleRequest_team.has_default_value = false
field_descriptors.SaveTeamRoleRequest_team.default_value = nil
field_descriptors.SaveTeamRoleRequest_team.message_type = type_descriptors.Team
field_descriptors.SaveTeamRoleRequest_team.type = 11
field_descriptors.SaveTeamRoleRequest_team.cpp_type = 10
type_descriptors.SaveTeamRoleRequest.name = "SaveTeamRoleRequest"
type_descriptors.SaveTeamRoleRequest.full_name = ".SaveTeamRoleRequest"
type_descriptors.SaveTeamRoleRequest.nested_types = {}
type_descriptors.SaveTeamRoleRequest.enum_types = {}
type_descriptors.SaveTeamRoleRequest.fields = {
	field_descriptors.SaveTeamRoleRequest_team
}
type_descriptors.SaveTeamRoleRequest.is_extendable = false
type_descriptors.SaveTeamRoleRequest.extensions = {}
field_descriptors.DeleteTeamReply_tid.name = "tid"
field_descriptors.DeleteTeamReply_tid.full_name = ".DeleteTeamReply.tid"
field_descriptors.DeleteTeamReply_tid.number = 1
field_descriptors.DeleteTeamReply_tid.index = 0
field_descriptors.DeleteTeamReply_tid.label = 1
field_descriptors.DeleteTeamReply_tid.has_default_value = false
field_descriptors.DeleteTeamReply_tid.default_value = 0
field_descriptors.DeleteTeamReply_tid.type = 5
field_descriptors.DeleteTeamReply_tid.cpp_type = 1
type_descriptors.DeleteTeamReply.name = "DeleteTeamReply"
type_descriptors.DeleteTeamReply.full_name = ".DeleteTeamReply"
type_descriptors.DeleteTeamReply.nested_types = {}
type_descriptors.DeleteTeamReply.enum_types = {}
type_descriptors.DeleteTeamReply.fields = {
	field_descriptors.DeleteTeamReply_tid
}
type_descriptors.DeleteTeamReply.is_extendable = false
type_descriptors.DeleteTeamReply.extensions = {}
field_descriptors.Team_tid.name = "tid"
field_descriptors.Team_tid.full_name = ".Team.tid"
field_descriptors.Team_tid.number = 1
field_descriptors.Team_tid.index = 0
field_descriptors.Team_tid.label = 1
field_descriptors.Team_tid.has_default_value = false
field_descriptors.Team_tid.default_value = 0
field_descriptors.Team_tid.type = 5
field_descriptors.Team_tid.cpp_type = 1
field_descriptors.Team_teamName.name = "teamName"
field_descriptors.Team_teamName.full_name = ".Team.teamName"
field_descriptors.Team_teamName.number = 2
field_descriptors.Team_teamName.index = 1
field_descriptors.Team_teamName.label = 1
field_descriptors.Team_teamName.has_default_value = false
field_descriptors.Team_teamName.default_value = ""
field_descriptors.Team_teamName.type = 9
field_descriptors.Team_teamName.cpp_type = 9
field_descriptors.Team_lastModifyTime.name = "lastModifyTime"
field_descriptors.Team_lastModifyTime.full_name = ".Team.lastModifyTime"
field_descriptors.Team_lastModifyTime.number = 3
field_descriptors.Team_lastModifyTime.index = 2
field_descriptors.Team_lastModifyTime.label = 1
field_descriptors.Team_lastModifyTime.has_default_value = false
field_descriptors.Team_lastModifyTime.default_value = 0
field_descriptors.Team_lastModifyTime.type = 3
field_descriptors.Team_lastModifyTime.cpp_type = 2
field_descriptors.Team_roles.name = "roles"
field_descriptors.Team_roles.full_name = ".Team.roles"
field_descriptors.Team_roles.number = 4
field_descriptors.Team_roles.index = 3
field_descriptors.Team_roles.label = 3
field_descriptors.Team_roles.has_default_value = false
field_descriptors.Team_roles.default_value = {}
field_descriptors.Team_roles.message_type = type_descriptors.TeamCell
field_descriptors.Team_roles.type = 11
field_descriptors.Team_roles.cpp_type = 10
type_descriptors.Team.name = "Team"
type_descriptors.Team.full_name = ".Team"
type_descriptors.Team.nested_types = {}
type_descriptors.Team.enum_types = {}
type_descriptors.Team.fields = {
	field_descriptors.Team_tid,
	field_descriptors.Team_teamName,
	field_descriptors.Team_lastModifyTime,
	field_descriptors.Team_roles
}
type_descriptors.Team.is_extendable = false
type_descriptors.Team.extensions = {}
field_descriptors.DeleteTeamRequest_tid.name = "tid"
field_descriptors.DeleteTeamRequest_tid.full_name = ".DeleteTeamRequest.tid"
field_descriptors.DeleteTeamRequest_tid.number = 1
field_descriptors.DeleteTeamRequest_tid.index = 0
field_descriptors.DeleteTeamRequest_tid.label = 1
field_descriptors.DeleteTeamRequest_tid.has_default_value = false
field_descriptors.DeleteTeamRequest_tid.default_value = 0
field_descriptors.DeleteTeamRequest_tid.type = 5
field_descriptors.DeleteTeamRequest_tid.cpp_type = 1
type_descriptors.DeleteTeamRequest.name = "DeleteTeamRequest"
type_descriptors.DeleteTeamRequest.full_name = ".DeleteTeamRequest"
type_descriptors.DeleteTeamRequest.nested_types = {}
type_descriptors.DeleteTeamRequest.enum_types = {}
type_descriptors.DeleteTeamRequest.fields = {
	field_descriptors.DeleteTeamRequest_tid
}
type_descriptors.DeleteTeamRequest.is_extendable = false
type_descriptors.DeleteTeamRequest.extensions = {}
type_descriptors.LoadTeamsRequest.name = "LoadTeamsRequest"
type_descriptors.LoadTeamsRequest.full_name = ".LoadTeamsRequest"
type_descriptors.LoadTeamsRequest.nested_types = {}
type_descriptors.LoadTeamsRequest.enum_types = {}
type_descriptors.LoadTeamsRequest.fields = {}
type_descriptors.LoadTeamsRequest.is_extendable = false
type_descriptors.LoadTeamsRequest.extensions = {}
DeleteTeamReply = protobuf.Message(type_descriptors.DeleteTeamReply)
DeleteTeamRequest = protobuf.Message(type_descriptors.DeleteTeamRequest)
EditTeamNameRequest = protobuf.Message(type_descriptors.EditTeamNameRequest)
LoadTeamsRequest = protobuf.Message(type_descriptors.LoadTeamsRequest)
SaveTeamRoleRequest = protobuf.Message(type_descriptors.SaveTeamRoleRequest)
Team = protobuf.Message(type_descriptors.Team)
TeamCell = protobuf.Message(type_descriptors.TeamCell)
TeamsInfoReply = protobuf.Message(type_descriptors.TeamsInfoReply)

return _G["logic.proto.TeamEditExtension_pb"]
