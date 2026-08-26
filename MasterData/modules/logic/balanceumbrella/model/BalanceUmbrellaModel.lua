-- chunkname: @modules/logic/balanceumbrella/model/BalanceUmbrellaModel.lua

module("modules.logic.balanceumbrella.model.BalanceUmbrellaModel", package.seeall)

local BalanceUmbrellaModel = class("BalanceUmbrellaModel", BaseModel)

function BalanceUmbrellaModel:onInit()
	self._newClueDict = nil
	self._noPlayClueDict = nil
	self._allUnLockClues = {}
	self._waitFirstInit = true
end

function BalanceUmbrellaModel:reInit()
	self:onInit()
end

function BalanceUmbrellaModel:refreshUnlock(isFirst)
	if not isFirst and self._waitFirstInit then
		return
	end

	self._waitFirstInit = false

	if isFirst then
		self._allUnLockClues = {}

		for i, co in ipairs(lua_balance_umbrella.configList) do
			if co.episode > 0 and DungeonModel.instance:hasPassLevel(co.episode) then
				table.insert(self._allUnLockClues, co.id)
			end
		end
	else
		local dirty = false

		for i, co in ipairs(lua_balance_umbrella.configList) do
			if co.episode > 0 and not tabletool.indexOf(self._allUnLockClues, co.id) and DungeonModel.instance:hasPassLevel(co.episode) then
				table.insert(self._allUnLockClues, co.id)
				self:onGetNewId(co.id)

				dirty = true
			end
		end

		if dirty then
			self:_saveLocalData()
			BalanceUmbrellaController.instance:dispatchEvent(BalanceUmbrellaEvent.ClueUpdate)
		end
	end
end

function BalanceUmbrellaModel:getAllNewIds()
	self:_initLocalData()

	return self._newClueDict
end

function BalanceUmbrellaModel:getAllNoPlayIds()
	self:_initLocalData()

	return self._noPlayClueDict
end

function BalanceUmbrellaModel:markAllNewIds()
	if not self._newClueDict[1] then
		return
	end

	self._newClueDict = {}

	PlayerPrefsHelper.deleteKey(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.BalanceUmbrellaNew))
end

function BalanceUmbrellaModel:markAllNoPlayIds()
	if not self._noPlayClueDict[1] then
		return
	end

	self._noPlayClueDict = {}

	PlayerPrefsHelper.deleteKey(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.BalanceUmbrellaNoPlayAnim))
end

function BalanceUmbrellaModel:_initLocalData()
	if not self._newClueDict then
		self._newClueDict = {}
		self._noPlayClueDict = {}

		local newIdStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.BalanceUmbrellaNew), "")
		local noPlayStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.BalanceUmbrellaNoPlayAnim), "")

		if not string.nilorempty(newIdStr) then
			self._newClueDict = cjson.decode(newIdStr)
		end

		if not string.nilorempty(noPlayStr) then
			self._noPlayClueDict = cjson.decode(noPlayStr)
		end
	end
end

function BalanceUmbrellaModel:onGetNewId(id)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BalanceUmbrellaClueView, {
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

function BalanceUmbrellaModel:_saveLocalData()
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.BalanceUmbrellaNew), cjson.encode(self._newClueDict))
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.BalanceUmbrellaNoPlayAnim), cjson.encode(self._noPlayClueDict))
end

function BalanceUmbrellaModel:isClueUnlock(id)
	return tabletool.indexOf(self._allUnLockClues, id)
end

function BalanceUmbrellaModel:isHaveClue()
	return not not self._allUnLockClues[1]
end

function BalanceUmbrellaModel:isGetAllClue()
	return #self._allUnLockClues == #lua_balance_umbrella.configList
end

BalanceUmbrellaModel.instance = BalanceUmbrellaModel.New()

return BalanceUmbrellaModel
