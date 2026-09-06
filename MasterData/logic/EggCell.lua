-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/egg/EggCell.lua

module("logic.extensions.material.proxy.egg.EggCell", package.seeall)

local EggCell = class("EggCell", ItemCell)

function EggCell:ctor(target)
	EggCell.super.ctor(self, target)
	self:dispose()
end

function EggCell:setBgActive(isActive)
	self.imgBg.enabled = isActive
end

function EggCell:setData(data)
	self.data = data

	if data then
		MaterialMgr.setIcon(self.icon, self.type, data.raceId)
		self.iconBg:SetState(0)
	end
end

function EggCell:setCfgData(cfg)
	ItemCell.super.setCfgData(self, cfg)
	GameUtil.addClickHandler(self.target, self._OnClick, self)
	GameUtil.SetActive(self.tag, false)
	GameUtil.SetActive(self.tagGift, false)
	self.icon:SetActive(true)
	self.iconBg:SetState(0)
	goutil.setActive(self._imgTagColorChange.gameObject, false)

	if self._effSSR then
		UIEffectManager.instance:stopEffect(self._effSSR)

		self._effSSR = nil
	end

	if cfg then
		self.icon:SetActive(true)
		MaterialMgr.setIcon(self.icon, self.type, cfg.raceId)
		self.iconBg:SetState(0)
	end
end

function EggCell:OnDestroy()
	EggCell.super.OnDestroy(self)

	self.target = nil
	self.data = nil
	self._clickBack = nil
end

function EggCell:setSelected(isSelected)
	self.selected.gameObject:SetActive(isSelected)
end

function EggCell:setCallBack(cb)
	self._clickBack = cb
end

function EggCell:_OnClick()
	GameUtil.callBack(self._clickBack, self)

	if self.autoTips then
		CommonTipsMgr.instance:_openOneView(ViewName.ZoodetailsView, ZooModel.instance:getEggById(self.data.id), ZooController.EGGTYPE)
	end
end

function EggCell:setGray(boo)
	uGuiUtil.setImageGrayStateRecursive(self.target, boo)
end

return EggCell
