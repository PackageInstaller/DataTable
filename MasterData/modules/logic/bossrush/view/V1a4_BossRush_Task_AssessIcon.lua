-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_Task_AssessIcon.lua

module("modules.logic.bossrush.view.V1a4_BossRush_Task_AssessIcon", package.seeall)

local V1a4_BossRush_Task_AssessIcon = class("V1a4_BossRush_Task_AssessIcon", LuaCompBase)

function V1a4_BossRush_Task_AssessIcon:init(go)
	self._goAssessEmpty = gohelper.findChild(go, "#go_AssessEmpty")
	self._goNotEmpty = gohelper.findChild(go, "#go_NotEmpty")
	self._goVxCircle = gohelper.findChild(go, "#go_NotEmpty/#go_vx_circle")
	self._imageAssessIcon = gohelper.findChildSingleImage(go, "#go_NotEmpty/#image_AssessIcon")

	local go3s = gohelper.findChildSingleImage(go, "#go_NotEmpty/#go_AssessIcon_sss")
	local go4s = gohelper.findChildSingleImage(go, "#go_NotEmpty/#go_AssessIcon_sss2")
	local go5s = gohelper.findChildSingleImage(go, "#go_NotEmpty/#go_AssessIcon_sss3")
	local go6s = gohelper.findChildSingleImage(go, "#go_NotEmpty/#go_AssessIcon_sss4")

	self._goAssessIcon = self._imageAssessIcon.gameObject
	self._govx = self:getUserDataTb_()
	self._govx[BossRushEnum.ScoreLevelStr.SSS] = go3s
	self._govx[BossRushEnum.ScoreLevelStr.SSSS] = go4s
	self._govx[BossRushEnum.ScoreLevelStr.SSSSS] = go5s
	self._govx[BossRushEnum.ScoreLevelStr.SSSSSS] = go6s
end

function V1a4_BossRush_Task_AssessIcon:setData(stage, score, type)
	local spriteName, level, strLevel = BossRushConfig.instance:getAssessSpriteName(stage, score, type)
	local isEmpty = spriteName == ""

	if not isEmpty then
		local res = ResUrl.getV1a4BossRushAssessIcon(spriteName)

		self._imageAssessIcon:LoadImage(res)

		local scoreVX = self._govx[strLevel]

		if scoreVX then
			local image = scoreVX:GetComponent(gohelper.Type_Image)

			if not isEmpty then
				scoreVX:LoadImage(res, function()
					image:SetNativeSize()
				end)
			end
		end

		for lv, go in pairs(self._govx) do
			local isShow = scoreVX == go

			gohelper.setActive(go, isShow)
		end
	end

	gohelper.setActive(self._goVxCircle, level >= 5)
	gohelper.setActive(self._goAssessEmpty, isEmpty)
	gohelper.setActive(self._goNotEmpty, not isEmpty)
end

function V1a4_BossRush_Task_AssessIcon:onClose()
	return
end

function V1a4_BossRush_Task_AssessIcon:onDestroyView()
	self._imageAssessIcon:UnLoadImage()

	for _, vx in pairs(self._govx) do
		vx:UnLoadImage()
	end
end

return V1a4_BossRush_Task_AssessIcon
