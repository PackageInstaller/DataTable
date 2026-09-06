-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/jump/JumpCell.lua

module("logic.extensions.material.proxy.jump.JumpCell", package.seeall)

local JumpCell = class("JumpCell", MaterialCell)

JumpCell.NONE = 0
JumpCell.TYPE_COUNT_DOWN_END = 1
JumpCell.TYPE_COUNT_CUSTOMIZE = 2

function JumpCell:ctor(target)
	JumpCell.super.ctor(self, target)

	self.icon = goutil.findChild(self.target, "ImgIcon")
	self.txtName = goutil.findChildTextComponent(self.target, "TxtName")
	self.imgBg = goutil.findChildComponent(self.target, "ImgBg", "Image")

	GameUtil.addClickHandler(self.target, self._OnClick, self)

	self.imgTime = goutil.findChild(self.target, "imgTime")
	self.txtTime = goutil.findChildTextComponent(self.target, "imgTime/txtTime")
end

function JumpCell:setCfgData(cfg)
	JumpCell.super.setCfgData(self, cfg)
	self.icon:SetActive(false)

	self.leftTimeSec = 0
	self.txtName.text = ""

	GameUtil.SetActive(self.imgTime, false)

	if cfg then
		MaterialMgr.setIcon(self.icon, self.type, cfg.id)
		self.icon:SetActive(true)

		if string.nilorempty(cfg.name) then
			local cc = FuncOpenConfig.instance:getFunctionOpenById(cfg.funcId)

			if cc then
				self.txtName.text = cc.name
			end
		else
			self.txtName.text = cfg.name
		end

		if cfg.showTimeType == JumpCell.TYPE_COUNT_DOWN_END then
			local redId = cfg.redId
			local info = RedPointModel.instance:getRedPoingInfo(redId)

			if info and checknumber(info.endTime) > 0 then
				self.leftTimeSec = checknumber(info.endTime) / 1000 - ServerTime.now()
			end
		elseif cfg.showTimeType == JumpCell.TYPE_COUNT_CUSTOMIZE and cfg.id == 27 then
			self.leftTimeSec = PartySummaryModel.instance:getPartyFoodTermEndTime()
		end

		if self.leftTimeSec > 0 then
			GameUtil.SetActive(self.imgTime, true)
			self:_showTime()
			settimer(1, self._countingTime, self)
		end
	end
end

function JumpCell:OnDestroy()
	JumpCell.super.OnDestroy(self)
	removetimer(self._countingTime, self)
end

function JumpCell:_countingTime()
	self.leftTimeSec = checknumber(self.leftTimeSec) - 1

	self:_showTime()
end

function JumpCell:_showTime()
	self.txtTime.text = GameUtil.FormatTimeSymbol(self.leftTimeSec)

	if self.cfg.showTimeType == JumpCell.TYPE_COUNT_CUSTOMIZE and checknumber(self.leftTimeSec) == 0 and self.cfg.id == 27 then
		self.leftTimeSec = PartySummaryModel.instance:getPartyFoodTermEndTime()

		return
	end

	if checknumber(self.leftTimeSec) <= 0 then
		removetimer(self._countingTime, self)
		GameUtil.SetActive(self.imgTime, false)
	end
end

function JumpCell:setCallBack(cb)
	self._clickBack = cb
end

function JumpCell:_OnClick()
	GameUtil.callBack(self._clickBack, self)

	if self.autoTips then
		GotoMgr.gotoByString(self.cfg.jumpTo)
	end
end

function JumpCell:dispose()
	JumpCell.super.dispose(self)

	self._clickBack = nil
end

function JumpCell:setGray(boo)
	uGuiUtil.setImageGrayStateRecursive(self.target, boo)
end

return JumpCell
