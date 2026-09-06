-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/rune/RuneCell.lua

module("logic.extensions.material.proxy.rune.RuneCell", package.seeall)

local RuneCell = class("RuneCell", MaterialCell)

function RuneCell:ctor(target)
	RuneCell.super.ctor(self, target)

	self.icon = goutil.findChild(self.target, "ImgIcon")
	self.iconBg = goutil.findChild(self.target, "ImgBg"):GetComponent("UIImageSpriteChange")
	self.Image = goutil.findChild(self.target, "numBg")
	self.txtNum = goutil.findChild(self.target, "TxtNum"):GetComponent("Text")
	self.selected = goutil.findChild(self.target, "Select")
	self.imgLock = goutil.findChild(self.target, "Lock")
	self.txtLvl = goutil.findChildTextComponent(self.target, "txtLvl")
	self.imgBg = goutil.findChildComponent(self.target, "ImgBg", "Image")
	self.topGo = goutil.findChild(self.target, "topGo")

	self:dispose()
	self:setNum(0)
end

function RuneCell:setBgActive(isActive)
	self.imgBg.enabled = isActive
end

function RuneCell:setData(data)
	self.data = data

	self:setLvl(0)
	GameUtil.SetActive(self.imgLock, false)
	self:setNum(0)

	if data ~= nil then
		if data.isLocked then
			GameUtil.SetActive(self.imgLock, true)
		end

		self:setLvl(data.level)
	end
end

function RuneCell:setLvl(num)
	self.txtLvl.text = num
end

function RuneCell:setNum(allNum, useNum)
	self.num = allNum
	self.txtNum.text = ""

	GameUtil.SetActive(self.Image, false)

	if self.num > 0 then
		GameUtil.SetActive(self.Image, true)

		self.txtNum.text = useNum and useNum >= 0 and useNum .. "/" .. allNum or tostring(allNum)
	end
end

function RuneCell:setCfgData(cfg)
	RuneCell.super.setCfgData(self, cfg)
	GameUtil.addClickHandler(self.target, self._OnClick, self)
	self.icon:SetActive(false)
	self.iconBg:SetState(0)

	if self._effSSR then
		UIEffectManager.instance:stopEffect(self._effSSR)

		self._effSSR = nil
	end

	if cfg then
		MaterialMgr.setIcon(self.icon, self.type, cfg.defineId)
		self.icon:SetActive(true)
		self.iconBg:SetState(cfg.quality or 0)

		self._effSSR = self:playRareEffect(cfg.quality or 0, self.topGo)
	end
end

function RuneCell:OnDestroy()
	RuneCell.super.OnDestroy(self)

	self.target = nil
	self.data = nil
	self._clickBack = nil
end

function RuneCell:setSelected(isSelected)
	self.selected.gameObject:SetActive(isSelected)
end

function RuneCell:setCallBack(cb)
	self._clickBack = cb
end

function RuneCell:_OnClick()
	print(">>>>>>>>>>>RuneCell cell click")
	GameUtil.callBack(self._clickBack, self)

	if self.autoTips then
		if self.data then
			CommonTipsMgr.instance:openMaterialTips(self.icon, self.type, self.data.runeId, self.num)
		else
			CommonTipsMgr.instance:openMaterialTips(self.icon, self.type, self.id, self.num)
		end
	end
end

function RuneCell:dispose()
	RuneCell.super.dispose(self)

	self._clickBack = nil

	self:setSelected(false)
	self.icon:SetActive(false)
	self.iconBg:SetState(0)

	self.txtNum.text = ""

	self:setBgActive(true)
	GameUtil.SetActive(self.imgLock, false)
	MaterialMgr.clearIcon(self.icon)

	if self._effSSR then
		UIEffectManager.instance:stopEffect(self._effSSR)

		self._effSSR = nil
	end
end

return RuneCell
