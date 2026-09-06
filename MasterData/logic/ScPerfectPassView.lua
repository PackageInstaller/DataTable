-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/ScPerfectPassView.lua

module("logic.extensions.scenariocopy.view.ScPerfectPassView", package.seeall)

local ScPerfectPassView = class("ScPerfectPassView", PerfectPassView)

function ScPerfectPassView:onEnter()
	local param = self:getOpenParam()
	local chapterId = param[1]
	local stageId = param[2]
	local cfg = ScenariocopyConfig.instance:getStageCfg(chapterId, stageId)

	if cfg then
		self:_showItems(cfg.perfectReward)

		local winCfg = BattleSettlementConfig.instance:getBattlePerfectWinOpCfgById(cfg.perfectWinId)

		num = checknumber(winCfg.params)
		self._txtDesc.text = string.format("完美通关：阵亡精灵不超过%d个", num)
	end

	self._roleModel.transform.localScale = Vector3.New(-1, 1, 1)

	self:_showRoleModel()
end

return ScPerfectPassView
