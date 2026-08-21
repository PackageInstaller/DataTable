-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preinstall/CharacterPreinstallAgent.lua

module("logic.extensions.charactersystem.view.preinstall.CharacterPreinstallAgent", package.seeall)

local M = class("CharacterPreinstallAgent", BaseAgent)

function M:ctor()
	return
end

function M:sendSavePresetRequest(msg, isSaveName, handler)
	self._isAddNew = false

	local msgp = PresetExtension_pb.SavePresetRequest()

	if isSaveName then
		msgp.presets.hero = msg.hero
		msgp.presets.id = msg.id
		msgp.presets.name = msg.name
		self._handler = handler
	else
		msgp.presets.hero = msg.hero
		msgp.presets.id = msg.id
		msgp.presets.name = msg.name
		msgp.presets.echo = msg.echo
		msgp.presets.equip1 = msg.equip1
		msgp.presets.equip2 = msg.equip2
		msgp.presets.equip3 = msg.equip3
		msgp.presets.thinking = msg.thinking
		msgp.presets.skill = msg.skill
		msgp.presets.lastModifyTime = msg.lastModifyTime
		self._isAddNew = true
	end

	self:sendMsg(msgp)
end

function M:handleSavePresetReply(status, msg)
	if status == 0 then
		if self._isAddNew == true then
			CharacterPreinstallController.instance:onHeroSavePreinstallReply(true)

			self._isAddNew = false
		else
			CharacterPreinstallController.instance:onHeroSavePreinstallReply(false)
		end
	elseif self._handler then
		self._handler:setOriginalNameOfPreinstall()
	end
end

function M:sendDeletePresetRequest(msg)
	local msgp = PresetExtension_pb.DeletePresetRequest()

	msgp.presets.hero = msg.hero
	msgp.presets.id = msg.id

	self:sendMsg(msgp)
end

function M:handleDeletePresetReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:sendApplyPresetRequest(msg)
	local msgp = PresetExtension_pb.ApplyPresetRequest()

	msgp.presets.hero = msg.hero
	msgp.presets.id = msg.id

	self:sendMsg(msgp)
end

function M:handleApplyPresetReply(status, msg)
	if status == 0 then
		CharacterPreinstallController.instance:onHeroApplyPreinstallReply()
	end
end

function M:handlePresetsChangedPush(status, msg)
	if status == 0 then
		if self._isAddNew == true then
			CharacterPreinstallController.instance:onHeroPreinstallListReply(msg.added, false, true)
		else
			CharacterPreinstallController.instance:onHeroPreinstallListReply(msg.added, false, false)
			CharacterPreinstallController.instance:onHeroPreinstallListReply(msg.deleted, true, false)
		end
	end
end

M.instance = M.New()

return M
