-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/controller/MaterialController.lua

module("logic.extensions.material.controller.MaterialController", package.seeall)

local MaterialController = class("MaterialController", BaseController)

MaterialController.TYPE_PET = 1
MaterialController.TYPE_ITEMSET = 2
MaterialController.TYPE_ITEMFLY = 3
MaterialController.TYPE_PET_SKIN = 4
MaterialController.CI_SHOW_TYPE_POPUP = 1
MaterialController.CI_SHOW_TYPE_FLY = 2
MaterialController.SHOW_TYPE_NORMAL = 0
MaterialController.SHOW_TYPE_NO_PET = 1

function MaterialController:ctor()
	self.extIDHashMap = {}
end

function MaterialController:onInit()
	self:onReset()
	MaterialAgent.instance:setShowChangeSetFunc(GameUtil.handler(self.onAgentChangeSet, self))
	MaterialAgent.instance:addHandler(MaterialAgent.NotifyMaterialChangedRes, self.onMaterialChange, self)
	GlobalDispatcher:addListener(GlobalNotify.SceneLoaded, self._OnSceneChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialPopEnd, self._OnSceneChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.OpenTaskCompleteView, self._onOpenTaskCompleteView, self)
end

function MaterialController:onAgentChangeSet(changeSetId, msgName, extId, cmd)
	if changeSetId ~= nil and changeSetId >= 0 then
		print(">>>>>>>>>物品准备弹出：找到下发 changeSetId =", changeSetId, msgName, self.showFunc)

		if msgName ~= "handleNotifyMaterialChangedRes" then
			MaterialFacade.instance:popAndShowChangeSetItems(changeSetId, extId, cmd)
		end
	end
end

function MaterialController:onReset()
	self.materialGetList = {}
	self.lockKeyList = {}
	self.lockKeyIdx = 0
	self.lockCount = 0
	self.materialChange = false
	self.changeItemsList = {}
	self.tempChangeSetMap = {}
	self.extIDHashMap = {}
	self.popupIdsMap = {}
	self.isShowingOverflowTips = false
	self.client_change_set_id = 0
end

function MaterialController:onMaterialChange(msg, status)
	local changesetid = msg.changeSetId
	local items = msg.items

	MaterialModel.instance:setMaterials(items, true)
	MaterialModel.instance:addChangeSetItems(changesetid, items)
	print(">>>>>物品有变化，changeSetId=", changesetid, "数量：", #items)

	self._resultCode = self._resultCode or usingnow("logicconfig.config.t_lang_tip_result_code")

	for i, item in ipairs(items) do
		local mtype = item.materialType
		local overflowItems = item.overflowItem

		if overflowItems then
			for i, overflowItem in ipairs(overflowItems) do
				local statusKey = "rc_" .. overflowItem.resultCode
				local statusStr = self._resultCode[statusKey]

				if statusStr then
					local langKey = "content" .. LanguageMgr.instance:getLanguageType()
					local msg = statusStr[langKey]

					self:addEndBattleFunc(mtype, overflowItem.id, msg)
				end
			end

			self:popupEndBattle()
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMaterialGet, msg)
end

function MaterialController:_OnSceneChanged()
	self:checkAndOpenDisplay()
end

function MaterialController:checkAndOpenDisplay()
	if SceneMgr.instance.isGogingToEnterBattleScene or TaskController.instance:hasTaskesAutoCompelete() then
		print(">>>>>>> 物品准备弹出： 不弹了！ SceneMgr.instance.isGogingToEnterBattleScene , TaskController.instance:hasTaskesAutoCompelete()", SceneMgr.instance.isGogingToEnterBattleScene, TaskController.instance:hasTaskesAutoCompelete())

		return
	end

	self:popupFly()

	if self:popupPet() then
		return
	end

	if self:popupItemset() then
		return
	end

	if self:popupEndBattle() then
		return
	end

	if self:popupPetSkin() then
		return
	end
end

function MaterialController:addEndBattleFunc(matType, id, msg)
	local key = matType .. "_" .. id

	self.sendMailList = self.sendMailList or {}

	if self.sendMailList[key] == nil then
		self.sendMailList[key] = {
			matType,
			id,
			msg
		}
	end
end

function MaterialController:popupEndBattle()
	if SceneMgr.instance.isGogingToEnterBattleScene then
		print(">>>>>>> 物品准备弹出： 判断在战斗中 SceneMgr.instance.isGogingToEnterBattleScene=true  不弹【获得溢出】面板")

		return false
	end

	if self.isShowingOverflowTips then
		return true
	end

	self.sendMailList = self.sendMailList or {}

	local list = {}
	local tempList = {}

	for i, v in pairs(self.sendMailList) do
		local mtype, id, msg = v[1], v[2], v[3]
		local name = MaterialModel.instance:getMaterialsName(mtype, id)

		table.insert(list, name)

		if mtype == MatType.Equipment then
			if tempList[MatType.Equipment] == nil then
				tempList[MatType.Equipment] = {}
			end

			table.insert(tempList[MatType.Equipment], name)
		end

		if mtype == MatType.Decoration then
			if tempList[MatType.Decoration] == nil then
				tempList[MatType.Decoration] = {}
			end

			table.insert(tempList[MatType.Decoration], name)
		end
	end

	self.sendMailList = nil

	if #list > 0 then
		self.isShowingOverflowTips = true

		local p = TipsFacade.instance:openTipWindowNoXExt(lang("tip"), tempList[MatType.Equipment] and #tempList[MatType.Equipment] > 0 and lang("获取装备数量已达上限，物品已通过邮件发放\n需要消耗部分装备才可继续领取\n可前往【奥核】-【炼金工坊】-【装备合成/装备强化】") or tempList[MatType.Decoration] and #tempList[MatType.Decoration] > 0 and lang("获取饰品数量已达上限，物品已通过邮件发放\n可先前往饰品分解，将饰品分解后可继续领取") or langPara("物品%s已经通过邮件发放，请注意查收。", table.concat(list, ",")), function()
			self.isShowingOverflowTips = false

			self:checkAndOpenDisplay()
		end)

		return true
	else
		return false
	end
end

function MaterialController:popupFly()
	local list = self:getList(MaterialController.TYPE_ITEMFLY)

	if #list > 0 then
		for i = 1, #list do
			local mo = list[i]

			ItemGetController.instance:showItemFlys(mo)
		end

		self:setList(MaterialController.TYPE_ITEMFLY, {})
	end

	return true
end

function MaterialController:popupPet()
	local list = self:getList(MaterialController.TYPE_PET)

	if #list > 0 then
		self:setList(MaterialController.TYPE_PET, {})

		for i = 1, #list do
			local mo = list[i]

			if mo.type == MatType.HIRE_PET then
				local info = PetHireModel.instance:getPetInfoByDefineId(mo.id)

				if info then
					PetDisplayController.instance:_onNewPet(info.petId)
				end
			else
				PetDisplayController.instance:_onNewPet(mo.id)
			end
		end

		PetDisplayController.instance:tryShowNext()

		return true
	end

	return false
end

function MaterialController:popupPetSkin()
	local list = self:getList(MaterialController.TYPE_PET_SKIN)

	if #list > 0 then
		self:setList(MaterialController.TYPE_PET_SKIN, {})

		for i = 1, #list do
			local mo = list[i]

			PetskinController.instance:_onNewPet(mo)

			local skinId = mo.id

			StoryPrizeController.instance:updateStoryPrizeStateBySkinId(skinId)
		end

		PetskinController.instance:checkAndOpenDisplay()

		return true
	end

	return false
end

function MaterialController:popupItemset()
	local list = self:getList(MaterialController.TYPE_ITEMSET)

	if #list > 0 then
		self:setList(MaterialController.TYPE_ITEMSET, {})

		for i = 1, #list do
			local moList = list[i]

			ItemGetController.instance:addShowItem(moList)
		end

		ItemGetController.instance:tryShowNextItem()

		return true
	end

	return false
end

function MaterialController:addInList(type, obj)
	if not self.materialGetList[type] then
		table.insert(self.materialGetList[type], obj)

		self.materialGetList[type] = self.materialGetList[type]
	end
end

function MaterialController:getList(type)
	self.materialGetList[type] = self.materialGetList[type] or {}

	return self.materialGetList[type]
end

function MaterialController:setList(type, list)
	self.materialGetList[type] = list
end

function MaterialController:isAllGetListEmpty()
	for i, list in pairs(self.materialGetList) do
		if list and #list > 0 then
			return false
		end
	end

	return true
end

function MaterialController:setChangeSetByExtId(changeSetId, extId, cmd)
	if extId == 7 and cmd == 2 then
		return
	end

	if checknumber(changeSetId) >= 0 and extId and type(changeSetId) ~= "table" then
		self.extIDHashMap[changeSetId] = extId
	elseif enableDebug then
		error(">>>>>>>>> 物品设置错误， changeSetId extId 不能为空 changeSetId 也不能为 数组 ，见到这个报错请反馈给开发。谢谢")
	end
end

function MaterialController:showItemsGetWindow(changeSetId, showType)
	if changeSetId ~= nil then
		local items = self:getItemsByChangeSetId(changeSetId)

		print(">>>>>>>>>>> 物品准备弹出：找到物品：", changeSetId, items)

		if items ~= nil then
			self:showChangeSetItemMo(items, changeSetId, showType)
		end
	end
end

function MaterialController:saveChangeSetToTemp(changeSetId)
	local items = self:getItemsByChangeSetId(changeSetId)

	if items ~= nil then
		self.tempChangeSetMap[changeSetId] = items
	end

	return items
end

function MaterialController:showChangeSetInTemp(changeSetId, showType)
	local items = self:getTempItemsByChangeSetId(changeSetId)

	if items ~= nil then
		self:showChangeSetItemMo(items, changeSetId, showType)
	end

	return items
end

function MaterialController:getTempItemsByChangeSetId(changeSetId)
	local items

	return (changeSetId ~= nil or nil) and (type(changeSetId) == "table" and MaterialModel.instance:popChnageSetList(changeSetId, self.tempChangeSetMap) or MaterialModel.instance:popChangeSetItems(changeSetId, self.tempChangeSetMap))
end

function MaterialController:getItemsByChangeSetId(changeSetId)
	local items

	return (changeSetId ~= nil or nil) and (type(changeSetId) == "table" and MaterialModel.instance:popChnageSetList(changeSetId) or MaterialModel.instance:popChangeSetItems(changeSetId))
end

function MaterialController:___getTempItemsByChangeSetIdOnlyRead(changeSetId)
	local items

	return (changeSetId ~= nil or nil) and self.tempChangeSetMap[changeSetId]
end

function MaterialController:___getItemsByChangeSetIdOnlyRead(changeSetId)
	local items

	return (changeSetId ~= nil or nil) and MaterialModel.instance:getMaterialMos(changeSetId)
end

function MaterialController:setChangeSetPopup(changeSetId, showType)
	showType = showType or MaterialController.CI_SHOW_TYPE_POPUP

	if changeSetId then
		self.popupIdsMap[changeSetId] = showType
	end
end

function MaterialController:getClientChangeSetId(isPop)
	self.client_change_set_id = self.client_change_set_id - 1

	if isPop then
		self:setChangeSetPopup(self.client_change_set_id)
	end

	return self.client_change_set_id
end

function MaterialController:getChangeSetPopup(changeSetId)
	local isPopupWindow = false

	if type(changeSetId) == "table" then
		for k, ci in pairs(changeSetId) do
			if checknumber(self.popupIdsMap[ci]) == MaterialController.CI_SHOW_TYPE_POPUP then
				isPopupWindow = true

				break
			end

			local extId = self.extIDHashMap[ci]
			local boo = MaterialConfig.instance:getIsPopupByExtId(extId)

			if boo then
				isPopupWindow = true

				break
			end
		end
	elseif self.popupIdsMap[changeSetId] ~= nil then
		isPopupWindow = checknumber(self.popupIdsMap[changeSetId]) == MaterialController.CI_SHOW_TYPE_POPUP
	elseif self.extIDHashMap[changeSetId] ~= nil then
		local extId = self.extIDHashMap[changeSetId]

		isPopupWindow = MaterialConfig.instance:getIsPopupByExtId(extId)
	end

	return isPopupWindow
end

function MaterialController:showChangeSetItemMo(itemsMoList, changeSetId, showType)
	showType = checknumber(showType)

	local datas = {}
	local list
	local isPopupWindow = checkbool(self:getChangeSetPopup(changeSetId))

	for k, v in pairs(itemsMoList) do
		if MaterialMgr.instance:getHasCell(v.type) then
			if v.type == MatType.Pet or v.type == MatType.HIRE_PET then
				if showType ~= MaterialController.SHOW_TYPE_NO_PET then
					self:addInList(MaterialController.TYPE_PET, v)
				end

				table.insert(datas, v)
			elseif v.type == MatType.PET_SKIN then
				self:addInList(MaterialController.TYPE_PET_SKIN, v)
			elseif isPopupWindow then
				table.insert(datas, v)
			else
				self:addInList(MaterialController.TYPE_ITEMFLY, v)
			end
		end
	end

	if datas and #datas > 0 then
		local obj = {}

		obj.items = datas
		obj.ci = changeSetId

		self:addInList(MaterialController.TYPE_ITEMSET, obj)
	end

	self:checkAndOpenDisplay()
end

function MaterialController:checkIsFlyType(matType, gid)
	local data = MaterialMgr.getModel(matType, gid)

	if data then
		local cfgId = data:getDefineId()
		local cfg = MaterialMgr.getMatCfg(matType, cfgId)

		return checknumber(cfg.showType) == 1
	end
end

function MaterialController:_onIsCheckItemSet(id, type, num)
	if type == MatType.Item then
		local cfg = ItemConfig.instance:getCfgById(checknumber(id))

		if not cfg.showType or cfg.showType and cfg.showType ~= 1 then
			return true
		else
			return false
		end
	elseif type == MatType.PokeBall then
		local cfg = BattleConfig.instance:getBattleItem(checknumber(id))

		if cfg ~= nil then
			return true
		end
	elseif type == MatType.Coin or type == MatType.Diamond then
		local cfg = MaterialMgr.getMatCfg(type, id)

		if num >= cfg.showLimit then
			return true
		else
			return false
		end
	end

	return true
end

function MaterialController:_onOpenTaskCompleteView()
	self:checkAndOpenDisplay()
end

function MaterialController:addUpdateMo(mo)
	if mo then
		local isFound = false

		for i, v in ipairs(self.changeItemsList) do
			if v.type == mo.type and v.id == mo.id then
				v.num = mo.num
				isFound = true

				break
			end
		end

		if not isFound then
			table.insert(self.changeItemsList, mo)
		end
	end

	self.materialChange = true
end

function MaterialController:lateUpdateMaterial()
	if self.materialChange then
		self.materialChange = false

		local changeItemsList = self.changeItemsList

		for k, mo in pairs(changeItemsList) do
			GlobalDispatcher:dispatch(GlobalNotify.OnMaterialItemChange, mo)
		end

		self.changeItemsList = {}

		GlobalDispatcher:dispatch(GlobalNotify.OnMaterialCountChange, changeItemsList)
	end
end

MaterialController.instance = MaterialController.New()

return MaterialController
