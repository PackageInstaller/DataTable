-- chunkname: @modules/logic/bossrush/view/v1a6/V1a6_BossRush_AssessIcon.lua

module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_AssessIcon", package.seeall)

local V1a6_BossRush_AssessIcon = class("V1a6_BossRush_AssessIcon", LuaCompBase)

function V1a6_BossRush_AssessIcon:onInitView()
	self._goAssessEmpty = gohelper.findChild(self.viewGO, "#go_AssessEmpty")
	self._goNotEmpty = gohelper.findChild(self.viewGO, "#go_NotEmpty")
	self._imageAssessIcon = gohelper.findChildSingleImage(self.viewGO, "#go_NotEmpty/#image_AssessIcon")
	self._txtScore = gohelper.findChildText(self.viewGO, "Score/#txt_Score")
	self._txtScoreNum = gohelper.findChildText(self.viewGO, "Score/#txt_ScoreNum")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_BossRush_AssessIcon:addEvents()
	return
end

function V1a6_BossRush_AssessIcon:removeEvents()
	return
end

function V1a6_BossRush_AssessIcon:_editableInitView()
	self._goScore = gohelper.findChild(self.viewGO, "Score")

	gohelper.setActive(self._goScore, false)
	self:initVX()
end

function V1a6_BossRush_AssessIcon:onUpdateParam()
	return
end

function V1a6_BossRush_AssessIcon:onOpen()
	return
end

function V1a6_BossRush_AssessIcon:onClose()
	return
end

function V1a6_BossRush_AssessIcon:onDestroyView()
	self._imageAssessIcon:UnLoadImage()
end

function V1a6_BossRush_AssessIcon:init(go)
	self.viewGO = go

	self:onInitView()
end

function V1a6_BossRush_AssessIcon:setData(stage, score, type, isNativeSize)
	if stage and score then
		local special = type == BossRushEnum.AssessType.Layer4
		local spriteName, level, strLevel = BossRushConfig.instance:getAssessSpriteName(stage, score, type)
		local _isEmpty = string.nilorempty(spriteName)

		gohelper.setActive(self._goNotEmpty, not _isEmpty)
		gohelper.setActive(self._goAssessEmpty, _isEmpty)

		if not _isEmpty then
			local image = gohelper.findChildImage(self.viewGO, "#go_NotEmpty/#image_AssessIcon")

			if not isNativeSize then
				local scale = special and 1.2 or 1

				transformhelper.setLocalScale(self._imageAssessIcon.transform, scale, scale, scale)
			end

			self._imageAssessIcon:LoadImage(ResUrl.getV1a4BossRushAssessIcon(spriteName), function()
				if isNativeSize then
					image:SetNativeSize()
				end
			end)
			self:showVX(strLevel)

			if level > 0 then
				AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.play_ui_settleaccounts_resources_rare)
			end

			return spriteName, level, strLevel
		end
	end
end

function V1a6_BossRush_AssessIcon:initVX()
	self.vxassess = {
		[BossRushEnum.BossRushEnum.ScoreLevelStr.SSS] = gohelper.findChild(self._imageAssessIcon.gameObject, "vx_sss"),
		[BossRushEnum.BossRushEnum.ScoreLevelStr.SSSS] = gohelper.findChild(self._imageAssessIcon.gameObject, "vx_sss2"),
		[BossRushEnum.BossRushEnum.ScoreLevelStr.SSSSS] = gohelper.findChild(self._imageAssessIcon.gameObject, "vx_sss3"),
		[BossRushEnum.BossRushEnum.ScoreLevelStr.SSSSSS] = gohelper.findChild(self._imageAssessIcon.gameObject, "vx_sss4")
	}

	self:showVX("")
end

function V1a6_BossRush_AssessIcon:showVX(level)
	if self.vxassess then
		for i, v in pairs(self.vxassess) do
			gohelper.setActive(v, level == i)
		end
	end
end

return V1a6_BossRush_AssessIcon
