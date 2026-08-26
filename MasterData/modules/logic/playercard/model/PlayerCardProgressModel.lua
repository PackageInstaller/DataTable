-- chunkname: @modules/logic/playercard/model/PlayerCardProgressModel.lua

module("modules.logic.playercard.model.PlayerCardProgressModel", package.seeall)

local PlayerCardProgressModel = class("PlayerCardProgressModel", ListScrollModel)

function PlayerCardProgressModel:refreshList()
	if #self._scrollViews == 0 then
		return
	end

	local dataList = {}

	for index, v in ipairs(PlayerCardConfig.instance:getCardProgressList()) do
		local mo = {}

		mo.index = index
		mo.config = v
		mo.info = self.cardInfo

		table.insert(dataList, mo)
	end

	table.sort(dataList, SortUtil.tableKeyLower({
		"index"
	}))
	self:setList(dataList)
end

function PlayerCardProgressModel:initSelectData(cardInfo)
	self.cardInfo = cardInfo

	self:initSelectList()

	self._lastSelectList = nil or tabletool.copy(self.selectList)

	self:setEmptyPosList()
end

function PlayerCardProgressModel:initSelectList()
	self.selectList = {}
	self._lastSelectList = nil

	local data = self.cardInfo:getProgressSetting()

	if data then
		for i, v in ipairs(data) do
			table.insert(self.selectList, v)
		end
	end
end

function PlayerCardProgressModel:clickItem(type)
	if not type then
		return
	end

	if self:checkhasMO(type) then
		self:removeSelect(type)
	else
		self:addSelect(type)
	end

	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshProgressView, self.selectList)
end

function PlayerCardProgressModel:checkhasMO(type)
	for _, selectMo in ipairs(self.selectList) do
		if selectMo[2] == type then
			return true
		end
	end

	return false
end

function PlayerCardProgressModel:addSelect(index)
	if #self.selectList >= PlayerCardEnum.MaxProgressCardNum then
		GameFacade.showToast(ToastEnum.PlayerCardMaxSelect)

		return
	end

	self:addSelectMo(index)
	self:setEmptyPosList()
	self:refreshList()
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SelectNumChange)
end

function PlayerCardProgressModel:removeSelect(index)
	self:removeSelectMo(index)
	self:setEmptyPosList()
	self:refreshList()
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SelectNumChange)
end

function PlayerCardProgressModel:getSelectIndex(index)
	for _, selectMo in ipairs(self.selectList) do
		if selectMo[2] == index then
			return selectMo[1]
		end
	end
end

function PlayerCardProgressModel:getemptypos()
	for pos, value in ipairs(self.emptyPosList) do
		if value then
			return pos
		end
	end
end

function PlayerCardProgressModel:setEmptyPosList()
	self.emptyPosList = {
		true,
		true,
		true,
		true,
		true
	}

	for i = 1, 5 do
		for _, mo in ipairs(self.selectList) do
			if mo[1] == i then
				self.emptyPosList[i] = false
			end
		end
	end
end

function PlayerCardProgressModel:getEmptyPosList()
	return self.emptyPosList
end

function PlayerCardProgressModel:addSelectMo(type)
	local emptypos = self:getemptypos()
	local mo = {
		emptypos,
		type
	}

	table.insert(self.selectList, mo)
end

function PlayerCardProgressModel:removeSelectMo(type)
	for index, selectmo in ipairs(self.selectList) do
		if selectmo[2] == type then
			table.remove(self.selectList, index)
		end
	end
end

function PlayerCardProgressModel:checkDiff()
	if #self._lastSelectList ~= #self.selectList then
		return true
	else
		local count = #self.selectList

		for i = 1, count do
			if self._lastSelectList[i][2] ~= self.selectList[i][2] then
				return true
			end
		end
	end

	return false
end

function PlayerCardProgressModel:reselectData()
	self:initSelectList()
	self:refreshList()
	self:setEmptyPosList()
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshProgressView, self.selectList)
end

function PlayerCardProgressModel:confirmData()
	if not self.selectList or not self.cardInfo then
		return
	end

	local list = {}

	for _, selectmo in ipairs(self.selectList) do
		local temp = table.concat(selectmo, "#")

		table.insert(list, temp)
	end

	local str = table.concat(list, "|")

	PlayerCardRpc.instance:sendSetPlayerCardProgressSettingRequest(str)

	self._lastSelectList = self.selectList
end

function PlayerCardProgressModel:getSelectNum()
	return #self.selectList
end

PlayerCardProgressModel.instance = PlayerCardProgressModel.New()

return PlayerCardProgressModel
