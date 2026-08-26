-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicFreeAccompanyView.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeAccompanyView", package.seeall)

local VersionActivity2_4MusicFreeAccompanyView = class("VersionActivity2_4MusicFreeAccompanyView", BaseView)

function VersionActivity2_4MusicFreeAccompanyView:onInitView()
	self._gotime = gohelper.findChild(self.viewGO, "root/#go_time")
	self._inputvalue = gohelper.findChildTextMeshInputField(self.viewGO, "root/#go_time/valuebg/#input_value")
	self._btnsub = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_time/#btn_sub")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_time/#btn_add")
	self._godynamics = gohelper.findChild(self.viewGO, "root/centercir/#go_dynamics")
	self._gocenter = gohelper.findChild(self.viewGO, "root/centercir/#go_center")
	self._gostate = gohelper.findChild(self.viewGO, "root/centercir/#go_state")
	self._gostate1 = gohelper.findChild(self.viewGO, "root/centercir/#go_state/#go_state1")
	self._gostate2 = gohelper.findChild(self.viewGO, "root/centercir/#go_state/#go_state2")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/centercir/#btn_click")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicFreeAccompanyView:addEvents()
	self._btnsub:AddClickListener(self._btnsubOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function VersionActivity2_4MusicFreeAccompanyView:removeEvents()
	self._btnsub:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btnclick:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function VersionActivity2_4MusicFreeAccompanyView:_btnclickOnClick()
	if not self._audioStartScale then
		return
	end

	local deltaTime = (self._audioStartScale - self._dynamicScale) * self._time * 1000

	self._curValue = math.ceil(deltaTime)

	if self._curValue < 0 then
		self._curValue = 0
	end

	self._audioStartScale = nil

	self:_checkLimit()
end

function VersionActivity2_4MusicFreeAccompanyView:_btnsubOnClick()
	self._curValue = self._curValue - self._stepValue

	self:_checkLimit()
end

function VersionActivity2_4MusicFreeAccompanyView:_btnaddOnClick()
	self._curValue = self._curValue + self._stepValue

	self:_checkLimit()
end

function VersionActivity2_4MusicFreeAccompanyView:_btncloseOnClick()
	self:closeThis()
end

function VersionActivity2_4MusicFreeAccompanyView:onClickModalMask()
	self:closeThis()
end

function VersionActivity2_4MusicFreeAccompanyView:_editableInitView()
	return
end

function VersionActivity2_4MusicFreeAccompanyView:onUpdateParam()
	return
end

function VersionActivity2_4MusicFreeAccompanyView:onOpen()
	self._minValue = 0
	self._maxValue = 2000
	self._stepValue = 1
	self._curValue = Activity179Model.instance:getCalibration() * 1000
	self._time = 2
	self._audioId = 20240027
	self._centerScale = 3
	self._startScale = 1
	self._endScale = 0
	self._audioScale = 0.75
	self._audioOffsetTime = (self._startScale - self._audioScale) * self._time * 1000

	self:_checkLimit()
	self._inputvalue:AddOnEndEdit(self._onEndEdit, self)
	self:_startCalibration()
end

function VersionActivity2_4MusicFreeAccompanyView:_updateInputValue()
	self._inputvalue:SetText(self._curValue)
end

function VersionActivity2_4MusicFreeAccompanyView:_onEndEdit()
	self._curValue = tonumber(self._inputvalue:GetText()) or 0

	self:_checkLimit()
end

function VersionActivity2_4MusicFreeAccompanyView:_checkLimit()
	self._curValue = math.max(self._minValue, math.min(self._maxValue, self._curValue))

	Activity179Model.instance:setCalibration(self._curValue)

	local value = self._curValue + self._audioOffsetTime

	self:_updateInputValue()

	local scale = (self._maxValue - value) / self._maxValue

	scale = scale * self._centerScale

	transformhelper.setLocalScale(self._gocenter.transform, scale, scale, scale)
end

function VersionActivity2_4MusicFreeAccompanyView:_startCalibration()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._audioStartScale = nil
	self._dynamicScale = self._startScale
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(self._startScale, self._endScale, self._time, self._frameCallback, self._tweenFinish, self)
end

function VersionActivity2_4MusicFreeAccompanyView:_frameCallback(value)
	if self._dynamicScale >= self._audioScale and value <= self._audioScale then
		AudioMgr.instance:trigger(self._audioId)

		self._audioStartScale = value
	end

	self._dynamicScale = value

	transformhelper.setLocalScale(self._godynamics.transform, value, value, value)
end

function VersionActivity2_4MusicFreeAccompanyView:_tweenFinish()
	self:_startCalibration()
end

function VersionActivity2_4MusicFreeAccompanyView:onClose()
	self._inputvalue:RemoveOnEndEdit()

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function VersionActivity2_4MusicFreeAccompanyView:onDestroyView()
	return
end

return VersionActivity2_4MusicFreeAccompanyView
