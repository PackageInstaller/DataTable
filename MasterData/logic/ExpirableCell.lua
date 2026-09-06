-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/item/ExpirableCell.lua

module("logic.extensions.material.proxy.item.ExpirableCell", package.seeall)

local ExpirableCell = class("ExpirableCell", MaterialCell)

function ExpirableCell:ctor(target)
	ExpirableCell.super.ctor(self, target)

	self.icon = goutil.findChild(self.target, "ImgIcon")
	self.iconBg = goutil.findChild(self.target, "ImgBg"):GetComponent("UIImageSpriteChange")
	self.txtNum = goutil.findChild(self.target, "TxtNum"):GetComponent("Text")
	self.selected = goutil.findChild(self.target, "Select")
	self.Image = goutil.findChild(self.target, "Image")
	self.selected = goutil.findChild(self.target, "Select")
	self.timeTag = goutil.findChild(self.target, "timeTag")
	self.txtTime = goutil.findChildTextComponent(self.timeTag, "txtTime")
	self.topGo = goutil.findChild(self.target, "topGo")

	self:dispose()
end

function ExpirableCell:setBgActive(isActive)
	self.iconBg.enabled = isActive
end

function ExpirableCell:setNum(allNum)
	self.num = allNum
	self.txtNum.text = ""

	GameUtil.SetActive(self.Image, false)

	if self.num > 0 then
		GameUtil.SetActive(self.Image, true)

		self.txtNum.text = tostring(allNum)
	end
end

function ExpirableCell:setDayLeft(dayNum)
	local dayLeft = checknumber(dayNum)

	self.timeTag:SetActive(dayLeft > 0)

	self.txtTime.text = langPara("%s天", dayLeft)
end

function ExpirableCell:setCfgData(cfg)
	ExpirableCell.super.setCfgData(self, cfg)
	GameUtil.addClickHandler(self.target, self._OnClick, self)
	self.icon:SetActive(false)
	self.timeTag:SetActive(false)
	self.iconBg:SetState(0)

	if self._effSSR then
		UIEffectManager.instance:stopEffect(self._effSSR)

		self._effSSR = nil
	end

	if cfg then
		MaterialMgr.setIcon(self.icon, self.type, cfg.id)
		self.icon:SetActive(true)
		self.iconBg:SetState(1 + (cfg.quality or 0))

		self._effSSR = self:playRareEffect(cfg.quality or 0, self.topGo)
	end
end

function ExpirableCell:setData(data)
	self.data = data

	self.timeTag:SetActive(false)

	if self.data ~= nil then
		GameUtil.SetActive(self.Image, false)

		self.txtNum.text = ""

		self.timeTag:SetActive(true)

		local expiraeTime = data:getExpiredTimeMillis() / 1000
		local dayLeft = 0

		if expiraeTime > 0 and expiraeTime > ServerTime.now() then
			dayLeft = math.ceil(checknumber((expiraeTime - ServerTime.now()) / 86400))
		end

		self.txtTime.text = dayLeft > 0 and langPara("%s天", dayLeft) or lang("已过期")
	end
end

function ExpirableCell:OnDestroy()
	ExpirableCell.super.OnDestroy(self)

	self.target = nil
	self._clickBack = nil
end

function ExpirableCell:setSelected(isSelected)
	self.selected.gameObject:SetActive(isSelected)
end

function ExpirableCell:setCallBack(cb)
	self._clickBack = cb
end

function ExpirableCell:_OnClick()
	GameUtil.callBack(self._clickBack, self)

	if self.autoTips then
		CommonTipsMgr.instance:openMaterialTips(self.icon, self.type, self.id, self.num)
	end
end

function ExpirableCell:dispose()
	ExpirableCell.super.dispose(self)

	self._clickBack = nil
	self.data = nil

	self:setSelected(false)
	self.icon:SetActive(false)
	self.iconBg:SetState(0)

	self.txtNum.text = ""

	MaterialMgr.clearIcon(self.icon)
	self:setBgActive(true)

	if self._effSSR then
		UIEffectManager.instance:stopEffect(self._effSSR)

		self._effSSR = nil
	end
end

return ExpirableCell
