-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Main\\MainStageLoading.lua

local MainStageLoading = Class("MainStageLoading", UIControls.Window)

function MainStageLoading:ctor()
	self.imgBg = UIControls.RawImage(self, "Bg")
	self.slierRun = UIControls.Slider(self, "SliderOther")
	self.panelAnim = UIControls.UIAni(self, "LightPanel")

	self:getController():InitLoadingProgress(self.imgBg:getGameObject(), 0.7, 3, Slot(self.onRunFinish, self))
	self.slierRun:setLoadingMode()

	self._isOver = false
end

function MainStageLoading:destroy()
	MainStageLoading.super.destroy(self)
end

function MainStageLoading:startLoad()
	self:getController():SetLoadingProgressValue(self.imgBg:getGameObject(), 0)
	self.slierRun:setValue(0)

	self.waitAni = true

	self:_update()
	CueManager.fadeOutBGM()
end

function MainStageLoading:_update()
	return
end

function MainStageLoading:setRate(r)
	self:getController():SetLoadingProgressValue(self.imgBg:getGameObject(), r)
	self.slierRun:setValue(r)

	if self.waitAni and r >= 0.8 then
		self.panelAnim:setVisible(true)
		self.panelAnim:startAni("ChangeLight", true)

		self.waitAni = false
	end

	if not self._isOver then
		return true
	end
end

function MainStageLoading:onRunFinish()
	self._isOver = true
end

return MainStageLoading
