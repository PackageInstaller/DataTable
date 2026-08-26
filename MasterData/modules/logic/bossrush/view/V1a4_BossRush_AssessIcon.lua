-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_AssessIcon.lua

module("modules.logic.bossrush.view.V1a4_BossRush_AssessIcon", package.seeall)

local V1a4_BossRush_AssessIcon = class("V1a4_BossRush_AssessIcon", LuaCompBase)

function V1a4_BossRush_AssessIcon:init(go)
	self._goAssessEmpty = gohelper.findChild(go, "#go_AssessEmpty")
	self._goNotEmpty = gohelper.findChild(go, "#go_NotEmpty")
	self._imageAssessIcon = gohelper.findChildSingleImage(go, "#go_NotEmpty/#image_AssessIcon")
	self._imageAssessIconTran = self._imageAssessIcon:GetComponent(gohelper.Type_RectTransform)
	self._goAssessEmptyTran = self._goAssessEmpty.transform
	self.lastLevel = nil

	local gos = gohelper.findChild(self._imageAssessIcon.gameObject, "vx_s")
	local go2s = gohelper.findChild(self._imageAssessIcon.gameObject, "vx_ss")
	local go3s = gohelper.findChild(self._imageAssessIcon.gameObject, "vx_sss")
	local go4s = gohelper.findChild(self._imageAssessIcon.gameObject, "vx_sss2")
	local go5s = gohelper.findChild(self._imageAssessIcon.gameObject, "vx_sss3")
	local go6s = gohelper.findChild(self._imageAssessIcon.gameObject, "vx_sss4")

	self._govx = self:getUserDataTb_()
	self._govx[BossRushEnum.ScoreLevelStr.SSS] = go3s
	self._govx[BossRushEnum.ScoreLevelStr.SSSS] = go4s
	self._govx[BossRushEnum.ScoreLevelStr.SSSSS] = go5s
	self._govx[BossRushEnum.ScoreLevelStr.SSSSSS] = go6s
	self.viewGO = go
end

local kEmptyWidthOverHeight = 1.6842105263157894

function V1a4_BossRush_AssessIcon:setIconSize(size)
	recthelper.setSize(self._imageAssessIconTran, size, size)
	recthelper.setSize(self._goAssessEmptyTran, size * kEmptyWidthOverHeight, size)
end

function V1a4_BossRush_AssessIcon:setData(stage, score, type)
	local spriteName, level, strLevel = BossRushConfig.instance:getAssessSpriteName(stage, score, type)
	local isEmpty = spriteName == ""
	local isChange = level > 0 and level ~= self.lastLevel

	if not isEmpty then
		local scale = type == BossRushEnum.AssessType.Layer4 and 1.2 or 1

		transformhelper.setLocalScale(self._imageAssessIcon.transform, scale, scale, scale)
		self._imageAssessIcon:LoadImage(ResUrl.getV1a4BossRushAssessIcon(spriteName))
	end

	gohelper.setActive(self._goAssessEmpty, isEmpty)
	gohelper.setActive(self._goNotEmpty, not isEmpty)

	if isChange then
		self:playVX()

		self.lastLevel = level
	end

	for lv, go in pairs(self._govx) do
		gohelper.setActive(go, lv == strLevel)
	end
end

function V1a4_BossRush_AssessIcon:playVX()
	if self._parentView and self._isPlayVX then
		TaskDispatcher.cancelTask(self.delayDisVX, self)
		self._parentView:playVX()
		TaskDispatcher.runDelay(self.delayDisVX, self, 0.8)
	end
end

function V1a4_BossRush_AssessIcon:delayDisVX()
	TaskDispatcher.cancelTask(self.delayDisVX, self)

	if self._parentView and self._isPlayVX then
		self._parentView:stopVX()
	end
end

function V1a4_BossRush_AssessIcon:initData(view, isPlayVX)
	self._parentView = view
	self._isPlayVX = isPlayVX

	TaskDispatcher.cancelTask(self.delayDisVX, self)
end

function V1a4_BossRush_AssessIcon:onDestroy()
	self:onDestroyView()
end

function V1a4_BossRush_AssessIcon:onDestroyView()
	self._imageAssessIcon:UnLoadImage()
end

return V1a4_BossRush_AssessIcon
