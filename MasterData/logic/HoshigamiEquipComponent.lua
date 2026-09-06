-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamiEquipComponent.lua

module("logic.extensions.hoshigami.view.HoshigamiEquipComponent", package.seeall)

local HoshigamiEquipComponent = class("HoshigamiEquipComponent", BaseLuaOnce)

function HoshigamiEquipComponent:ctor(go)
	HoshigamiEquipComponent.super.ctor(self, go)
end

function HoshigamiEquipComponent:buildUI()
	HoshigamiEquipComponent.super.buildUI(self)

	local equipCell = self:getGo("cell1")
	local equipRoot = self.mainGO.transform

	self._equipItems = {}

	local goList = {
		equipCell
	}

	for i = 2, 6 do
		goList[i] = goutil.cloneAndSetParent(equipCell, equipRoot, "cell" .. i)
	end

	for i, go in ipairs(goList) do
		local btn = Framework.ButtonAdapter.GetFrom(go, "raycast")
		local icon = goutil.findChild(go, "icon")
		local selectGo = goutil.findChild(go, "select")
		local lvText = goutil.findChildTextComponent(icon, "lvText")
		local bgChang = go:GetComponent(typeof(UIChangeGroup))
		local iconBgGo = goutil.findChild(go, "icon/bg")

		self._equipItems[i] = {
			btn = btn,
			icon = icon,
			selectGo = selectGo,
			lvText = lvText,
			bgChang = bgChang
		}

		local pos = GameEnum.HoshigamiEquipItemPos[i]

		GameUtil.setAnchoredPos(go, pos.x, pos.y)
		Framework.TransformUtil.SetLocalRotation(selectGo.transform, 0, 0, pos.rotate)
		Framework.TransformUtil.SetLocalRotation(iconBgGo.transform, 0, 0, pos.rotate)
	end
end

function HoshigamiEquipComponent:bindEvents()
	HoshigamiEquipComponent.super.bindEvents(self)

	for i, v in ipairs(self._equipItems) do
		v.btn:AddClickListener(function()
			self:_switchEquipType(i)
		end)
	end
end

function HoshigamiEquipComponent:unbindEvents()
	HoshigamiEquipComponent.super.unbindEvents(self)

	for i, v in ipairs(self._equipItems) do
		v.btn:RemoveClickListener()
	end
end

function HoshigamiEquipComponent:onEnter(callBackHandle, callBackHandleObj, autoSetSelect)
	HoshigamiEquipComponent.super.onEnter(self)

	self._callBackHandle = callBackHandle
	self._callBackHandleObj = callBackHandleObj
	self._autoSetSelect = autoSetSelect

	if autoSetSelect == nil then
		self._autoSetSelect = true
	end
end

function HoshigamiEquipComponent:onExit()
	HoshigamiEquipComponent.super.onExit(self)
	self:_resetEquipIcon()
end

function HoshigamiEquipComponent:OnDestroy()
	HoshigamiEquipComponent.super.OnDestroy(self)

	self._equipItems = nil
end

function HoshigamiEquipComponent:_resetEquipIcon()
	for i, v in ipairs(self._equipItems) do
		MaterialMgr.resetAll(v.icon)
	end
end

function HoshigamiEquipComponent:setSelect(posIndex)
	for i, v in ipairs(self._equipItems) do
		goutil.setActive(v.selectGo, posIndex == i)
	end
end

function HoshigamiEquipComponent:setEquipItem(posDataList)
	for i, v in ipairs(self._equipItems) do
		v.lvText.text = ""

		goutil.setActive(v.icon, false)
		goutil.setActive(v.selectGo, false)
	end

	posDataList = posDataList or {}

	for posType, hoshigami in pairs(posDataList) do
		local cfg = HoshigamiConfig.instance:getHoshigamiCfg(hoshigami.defineId)
		local iconGo = self._equipItems[posType].icon

		if hoshigami.lv then
			self._equipItems[posType].lvText.text = "+" .. hoshigami.lv or ""
		end

		self._equipItems[posType].bgChang:SetState(cfg.quality)
		goutil.setActive(iconGo, true)
		MaterialMgr.setIcon(iconGo, MatType.Hoshigami, hoshigami.defineId)
	end
end

function HoshigamiEquipComponent:_switchEquipType(posType)
	if self._autoSetSelect then
		self:setSelect(posType)
	end

	self._callBackHandle(self._callBackHandleObj, posType)
end

return HoshigamiEquipComponent
