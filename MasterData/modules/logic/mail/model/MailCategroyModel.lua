-- chunkname: @modules/logic/mail/model/MailCategroyModel.lua

module("modules.logic.mail.model.MailCategroyModel", package.seeall)

local MailCategroyModel = class("MailCategroyModel", ListScrollModel)

function MailCategroyModel:setCategoryList(infos, sort)
	self._moList = {}

	if infos then
		self._moList = infos

		if sort then
			table.sort(self._moList, self._sortFunction)
		end
	end

	self:setList(self._moList)
	self:_refreshCount()
end

function MailCategroyModel._sortFunction(x, y)
	local stateScore = 0
	local timeScore = 0

	if x.state < y.state then
		stateScore = 2
	elseif x.state > y.state then
		stateScore = -2
	end

	if x.createTime < y.createTime then
		timeScore = -1
	elseif x.createTime > y.createTime then
		timeScore = 1
	end

	return stateScore + timeScore > 0
end

function MailCategroyModel:addMail()
	self:_refreshCount()
end

function MailCategroyModel:refreshCategoryList(ids)
	MailController.instance:dispatchEvent(MailEvent.OnMailDel, ids)
	self:_refreshCount()
end

function MailCategroyModel:refreshCategoryItem(ids)
	MailController.instance:dispatchEvent(MailEvent.OnMailRead, ids)
	self:_refreshCount()
end

function MailCategroyModel:_refreshCount()
	MailController.instance:dispatchEvent(MailEvent.OnMailCountChange)
end

MailCategroyModel.instance = MailCategroyModel.New()

return MailCategroyModel
