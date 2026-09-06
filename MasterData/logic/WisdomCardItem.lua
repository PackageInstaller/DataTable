-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomaltar/view/WisdomCardItem.lua

module("logic.extensions.wisdomaltar.view.WisdomCardItem", package.seeall)

local WisdomCardItem = class("WisdomCardItem")
local LuaComponentContainer = Framework.LuaComponentContainer

function WisdomCardItem:ctor(component)
	self._target = component.gameObject
	self._iconParent = goutil.findChild(self._target, "Icon")

	local statusNode = goutil.findChild(self._target, "Status")

	if statusNode then
		statusNode:SetActive(true)

		self._imgPoint = goutil.findChild(self._target, "imgPoint")
		self._matAdd = goutil.findChild(statusNode, "MatAdd")
		self._selRole = goutil.findChild(statusNode, "SelRole")
		self._selMat = goutil.findChild(statusNode, "SelMat")
		self._selMask = goutil.findChild(statusNode, "Selected")
		self._lock = goutil.findChild(statusNode, "Lock")
	end

	self._reduceBtn = Framework.ButtonAdapter.GetFrom(self._target, "reduceBtn")
end

function WisdomCardItem.AddOnce(go)
	local component = LuaComponentContainer.Get(go, WisdomCardItem)

	component = component or LuaComponentContainer.Add(go, WisdomCardItem)

	return component
end

function WisdomCardItem.Remove(go)
	LuaComponentContainer.Remove(go, WisdomCardItem)
end

function WisdomCardItem:getIsPet()
	return self._isPet == true
end

function WisdomCardItem:getData()
	return self._mo
end

function WisdomCardItem:getTarget()
	if not goutil.isNil(self._iconParent) then
		return self._iconParent
	else
		return self._target
	end
end

function WisdomCardItem:onSetMo(mo)
	self._mo = mo
	self._isPet = type(mo) == "table"
	self._proxy = nil

	local parent = self:getTarget()

	MaterialMgr.resetAll(parent)

	if self._isPet then
		if mo then
			::label_7_0::

			local inTeam = FormationNewModel.instance:HasPetAtCurFormation(mo.petId)
			local proxy = MaterialMgr.setCellByData(MatType.Pet, mo, parent)

			if proxy and proxy.binder then
				proxy.binder:setSelected(false)
				proxy.binder:setUseLock(false)
				proxy.binder:SetInTeam(inTeam)
			end

			self._proxy = proxy
		end
	else
		local matId = mo
		local matType = MatType.Item
		local matNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
		local cfgStr = string.format("%s:%s:%s", matType, matId, matNum)

		self._proxy = MaterialMgr.setCellByCfg(cfgStr, parent)
	end
end

function WisdomCardItem:_getCardTag(itemId)
	local itemExtCfg = ItemConfig.instance:getAwakenItemExtCfgById(itemId)

	if itemExtCfg.isSameRace then
		local rare = itemExtCfg.level

		if rare == GameEnum.PetRare.UR then
			return GameEnum.AwakenCardTag.SameRaceIdUR
		else
			return GameEnum.AwakenCardTag.SameRaceIdSSR
		end
	end

	return 1
end

function WisdomCardItem:setStatus(selectPetId, isMatHandler, getMatSelNumHandler, handlerTarget, hasEmpty)
	self._imgPoint:SetActive(false)
	self._matAdd:SetActive(false)
	self._selRole:SetActive(false)
	self._selMat:SetActive(false)
	self._selMask:SetActive(false)
	self._lock:SetActive(false)
	self._proxy:setGray(false)
	self._reduceBtn.gameObject:SetActive(false)

	local selNum = getMatSelNumHandler(handlerTarget, self._mo)
	local isItemNotEnough = false

	if not self._isPet then
		local totalNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, self._mo)
		local leftNum = totalNum - selNum

		isItemNotEnough = leftNum <= 0

		self:setNumStr(selNum, totalNum)
	end

	if not selectPetId then
		if not self._isPet then
			self._selMask:SetActive(isItemNotEnough)
			self._matAdd:SetActive(isItemNotEnough)
		else
			self._selMask:SetActive(self._mo:isAwakenMax())

			local isActive = WisdomAltarModel.instance:isPetAwakable(self._mo)

			self._imgPoint:SetActive(isActive)
		end
	else
		local isMat = isMatHandler(handlerTarget, self._mo)
		local isMatSel = selNum > 0

		if self._isPet then
			if selectPetId == self._mo.petId then
				self._selRole:SetActive(true)
				self._selMask:SetActive(true)
			else
				self._selMat:SetActive(isMat and isMatSel)
				self._selMask:SetActive(isMat and isMatSel)
				self._lock:SetActive(not isMat)
				self._proxy:setGray(not isMat)
			end
		else
			self._lock:SetActive(not isMat)
			self._proxy:setGray(not isMat)

			if isMat and isItemNotEnough and hasEmpty then
				self._selMask:SetActive(true)
				self._matAdd:SetActive(true)
			end

			if selNum > 0 then
				self._reduceBtn.gameObject:SetActive(true)
			end
		end
	end
end

function WisdomCardItem:setNumStr(usedNum, totalNum)
	if self._proxy then
		self._proxy.binder:setNumStr((usedNum > 0 or nil) and usedNum .. "/" .. totalNum)
	end
end

function WisdomCardItem:setNum(num)
	if self._proxy then
		self._proxy.binder:setNum(num)
	end
end

return WisdomCardItem
