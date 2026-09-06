-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/FmtScoreView.lua

module("logic.extensions.mission.view.FmtScoreView", package.seeall)

local FmtScoreView = class("FmtScoreView", ViewComponent)

function FmtScoreView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._txtLevel = self:getGo("txtLevel"):GetComponent(goutil.Type_UIText)
	self._txtLevelColor = self:getGo("txtLevel"):GetComponent("UITextColorChange")
	self._txtScore = self:getGo("txtScore"):GetComponent(goutil.Type_UIText)
	self._txtContent = self:getGo("scrollContent/txtContent"):GetComponent(goutil.Type_UIText)
	self._btnExplainCustomInput = UICustomInput.Get(self:getGo("btnExplain"))
	self._tip = self:getGo("tip")

	self._tip:SetActive(false)
end

function FmtScoreView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnExplainCustomInput:AddListener(self._onClickExplain, self)
end

function FmtScoreView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnExplainCustomInput:RemoveListener()
end

function FmtScoreView:onEnter()
	local score, cfgList = FastFormation.instance:getCurrFmtValue()
	local txtLevel, index, calculateScore = MissionController.instance:getFmtEvaluate(score)

	self._txtLevel.text = txtLevel

	self._txtLevelColor:SetState(index)

	self._txtScore.text = Mathf.Floor(calculateScore)

	self:_showSubItemTxt(cfgList)
end

function FmtScoreView:onExit()
	return
end

function FmtScoreView:_onClickClose()
	self:close()
end

function FmtScoreView:_onClickExplain(hover)
	if hover then
		if not self._tip.activeSelf then
			self._tip:SetActive(true)
		else
			self._tip:SetActive(false)
		end
	elseif self._tip.activeSelf then
		self._tip:SetActive(false)
	end
end

function FmtScoreView:_showSubItemTxt(cfgList)
	local result = {}

	for i, list in ipairs(cfgList) do
		if list and #list > 0 then
			for i, v in ipairs(list) do
				local cfg = CharacterConfig.instance:getFormationGradeContent(v)

				if cfg then
					if result[cfg.desc] then
						local t = result[cfg.desc]

						t.count = t.count + 1
						t.score = t.score + cfg.score
					else
						local t = {}

						t.count = 1
						t.score = cfg.score
						result[cfg.desc] = t
					end
				end
			end
		end
	end

	table.sort(result, function(a, b)
		if a.score == b.score then
			return a.count > b.count
		else
			return a.score > b.score
		end
	end)

	local txt = ""

	for k, v in pairs(result) do
		txt = v.score >= 0 and txt .. string.format("%s 触发%d次 +%d%% \n", k, v.count, v.score) or txt .. string.format("%s 触发%d次 %d%% \n", k, v.count, v.score)
	end

	self._txtContent.text = txt
end

return FmtScoreView
