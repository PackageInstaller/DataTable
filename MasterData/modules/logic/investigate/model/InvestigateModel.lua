-- chunkname: @modules/logic/investigate/model/InvestigateModel.lua

module("modules.logic.investigate.model.InvestigateModel", package.seeall)

local InvestigateModel = class("InvestigateModel", BaseModel)

function InvestigateModel:onInit()
	self._newClueDict = nil
	self._noPlayClueDict = nil
	self._allUnLockClues = {}
	self._waitFirstInit = true
end

function InvestigateModel:reInit()
	self:onInit()
end

function InvestigateModel:refreshUnlock(isFirst)
	if not isFirst and self._waitFirstInit then
		return
	end

	self._waitFirstInit = false

	if isFirst then
		self._allUnLockClues = {}

		for i, co in ipairs(lua_investigate_info.configList) do
			if co.episode > 0 and DungeonModel.instance:hasPassLevel(co.episode) then
				table.insert(self._allUnLockClues, co.id)
			end
		end
	else
		local dirty = false

		for i, co in ipairs(lua_investigate_info.configList) do
			if co.episode > 0 and co.entrance > 0 and not tabletool.indexOf(self._allUnLockClues, co.id) and DungeonModel.instance:hasPassLevel(co.episode) then
				table.insert(self._allUnLockClues, co.id)
				self:onGetNewId(co.id)

				dirty = true
			end
		end

		if dirty then
			self:_saveLocalData()
			InvestigateController.instance:dispatchEvent(InvestigateEvent.ClueUpdate)
		end
	end
end

function InvestigateModel:getAllNewIds()
	self:_initLocalData()

	return self._newClueDict
end

function InvestigateModel:getAllNoPlayIds()
	self:_initLocalData()

	return self._noPlayClueDict
end

function InvestigateModel:markAllNewIds()
	if not self._newClueDict[1] then
		return
	end

	self._newClueDict = {}

	PlayerPrefsHelper.deleteKey(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.InvestigateNew))
end

function InvestigateModel:markAllNoPlayIds()
	if not self._noPlayClueDict[1] then
		return
	end

	self._noPlayClueDict = {}

	PlayerPrefsHelper.deleteKey(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.InvestigateNoPlayAnim))
end

function InvestigateModel:_initLocalData()
	if not self._newClueDict then
		self._newClueDict = {}
		self._noPlayClueDict = {}

		local newIdStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.InvestigateNew), "")
		local noPlayStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.InvestigateNoPlayAnim), "")

		if not string.nilorempty(newIdStr) then
			self._newClueDict = cjson.decode(newIdStr)
		end

		if not string.nilorempty(noPlayStr) then
			self._noPlayClueDict = cjson.decode(noPlayStr)
		end
	end
end

function InvestigateModel:onGetNewId(id)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.InvestigateClueView, {
			isGet = true,
			id = id
		})

		return
	end

	self:_initLocalData()
	table.insert(self._newClueDict, id)
	table.insert(self._noPlayClueDict, id)
	table.sort(self._newClueDict)
	table.sort(self._noPlayClueDict)
end

function InvestigateModel:_saveLocalData()
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.InvestigateNew), cjson.encode(self._newClueDict))
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.InvestigateNoPlayAnim), cjson.encode(self._noPlayClueDict))
end

function InvestigateModel:isClueUnlock(id)
	return tabletool.indexOf(self._allUnLockClues, id)
end

function InvestigateModel:isHaveClue()
	return not not self._allUnLockClues[1]
end

function InvestigateModel:isGetAllClue()
	return #self._allUnLockClues == #lua_investigate_info.configList
end

InvestigateModel.instance = InvestigateModel.New()

return InvestigateModel
