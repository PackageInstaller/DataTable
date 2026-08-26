-- chunkname: @modules/logic/playercard/model/PlayerCardBaseInfoModel.lua

module("modules.logic.playercard.model.PlayerCardBaseInfoModel", package.seeall)

local PlayerCardBaseInfoModel = class("PlayerCardBaseInfoModel", ListScrollModel)

function PlayerCardBaseInfoModel:refreshList()
	if #self._scrollViews == 0 then
		return
	end

	local dataList = {}

	for index, v in ipairs(PlayerCardConfig.instance:getCardBaseInfoList()) do
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

function PlayerCardBaseInfoModel:initSelectData(cardInfo)
	self.cardInfo = cardInfo

	self:initSelectList()

	if not self._lastSelectList then
		self._lastSelectList = tabletool.copy(self.selectList)

		table.remove(self._lastSelectList, 1)
	end

	self:setEmptyPosList()
end

function PlayerCardBaseInfoModel:initSelectList()
	self.selectList = {
		{
			1,
			PlayerCardEnum.RightContent.HeroCount
		}
	}

	local data = self.cardInfo:getBaseInfoSetting()

	if data then
		for i, v in ipairs(data) do
			table.insert(self.selectList, v)
		end
	end
end

function PlayerCardBaseInfoModel:clickItem(type)
	if not type then
		return
	end

	if self:checkhasMO(type) then
		self:removeSelect(type)
	else
		self:addSelect(type)
	end

	local tempselectList = {}

	for i = 2, #self.selectList do
		table.insert(tempselectList, self.selectList[i])
	end

	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshBaseInfoView, tempselectList)
end

function PlayerCardBaseInfoModel:checkhasMO(type)
	for _, selectMo in ipairs(self.selectList) do
		if selectMo[2] == type then
			return true
		end
	end

	return false
end

function PlayerCardBaseInfoModel:addSelect(index)
	if #self.selectList >= PlayerCardEnum.MaxBaseInfoNum then
		GameFacade.showToast(ToastEnum.PlayerCardMaxSelect)

		return
	end

	self:addSelectMo(index)
	self:setEmptyPosList()
	self:refreshList()
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SelectNumChange)
end

function PlayerCardBaseInfoModel:removeSelect(index)
	self:removeSelectMo(index)
	self:setEmptyPosList()
	self:refreshList()
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SelectNumChange)
end

function PlayerCardBaseInfoModel:getSelectIndex(type)
	for _, selectMo in ipairs(self.selectList) do
		if selectMo[2] == type then
			return selectMo[1]
		end
	end
end

function PlayerCardBaseInfoModel:getemptypos()
	for pos, value in ipairs(self.emptyPosList) do
		if value then
			return pos
		end
	end
end

function PlayerCardBaseInfoModel:setEmptyPosList()
	self.emptyPosList = {
		false,
		true,
		true,
		true
	}

	for i = 1, 4 do
		for _, mo in ipairs(self.selectList) do
			if mo[1] == i then
				self.emptyPosList[i] = false
			end
		end
	end
end

function PlayerCardBaseInfoModel:getEmptyPosList()
	return self.emptyPosList
end

function PlayerCardBaseInfoModel:addSelectMo(type)
	local emptypos = self:getemptypos()
	local mo = {
		emptypos,
		type
	}

	table.insert(self.selectList, mo)
end

function PlayerCardBaseInfoModel:removeSelectMo(type)
	for index, selectmo in ipairs(self.selectList) do
		if selectmo[2] == type then
			table.remove(self.selectList, index)
		end
	end
end

function PlayerCardBaseInfoModel:checkDiff()
	local list = tabletool.copy(self.selectList)

	table.remove(list, 1)

	if #self._lastSelectList ~= #list then
		return false
	else
		local count = #list

		for i = 1, count do
			if self._lastSelectList[i][2] ~= list[i][2] then
				return false
			end
		end
	end

	return true
end

function PlayerCardBaseInfoModel:reselectData()
	self:initSelectList()
	self:refreshList()
	self:setEmptyPosList()
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshBaseInfoView, self.selectList)
end

function PlayerCardBaseInfoModel:confirmData()
	if not self.selectList or not self.cardInfo then
		return
	end

	table.remove(self.selectList, 1)

	self._lastSelectList = tabletool.copy(self.selectList)

	local list = {}

	for _, selectmo in ipairs(self.selectList) do
		local temp = table.concat(selectmo, "#")

		table.insert(list, temp)
	end

	local str = table.concat(list, "|")

	PlayerCardRpc.instance:sendSetPlayerCardBaseInfoSettingRequest(str)
end

function PlayerCardBaseInfoModel:getSelectNum()
	return #self.selectList
end

PlayerCardBaseInfoModel.instance = PlayerCardBaseInfoModel.New()

return PlayerCardBaseInfoModel
