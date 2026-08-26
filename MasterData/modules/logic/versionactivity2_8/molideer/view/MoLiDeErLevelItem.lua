-- chunkname: @modules/logic/versionactivity2_8/molideer/view/MoLiDeErLevelItem.lua

module("modules.logic.versionactivity2_8.molideer.view.MoLiDeErLevelItem", package.seeall)

local MoLiDeErLevelItem = class("MoLiDeErLevelItem", LuaCompBase)

function MoLiDeErLevelItem:init(go)
	self.viewGO = go
	self._imagepoint = gohelper.findChildImage(self.viewGO, "#image_point_normal")
	self._imagepointFinish = gohelper.findChildImage(self.viewGO, "#image_point_finish")
	self._gostagefinish = gohelper.findChild(self.viewGO, "unlock/#go_stagefinish")
	self._gostagenormal = gohelper.findChild(self.viewGO, "unlock/#go_stagenormal")
	self._txtstagename = gohelper.findChildText(self.viewGO, "unlock/info/#txt_stagename")
	self._txtstageNum = gohelper.findChildText(self.viewGO, "unlock/info/#txt_stageNum")
	self._gostar = gohelper.findChild(self.viewGO, "unlock/info/#go_star")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "unlock/#btn_click")
	self._goCurrent = gohelper.findChild(self.viewGO, "unlock/#go_Current")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MoLiDeErLevelItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function MoLiDeErLevelItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function MoLiDeErLevelItem:_btnclickOnClick()
	local actId = self.actId
	local mo = ActivityModel.instance:getActMO(actId)

	if mo == nil then
		logError("not such activity id: " .. actId)

		return
	end

	if not mo:isOpen() or mo:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	local preEpisodeId = self.episodeConfig.preEpisodeId

	if preEpisodeId ~= 0 and not MoLiDeErModel.instance:isEpisodeFinish(actId, preEpisodeId) then
		GameFacade.showToast(ToastEnum.Act194EpisodeLock)

		return
	end

	local episodeId = self.episodeConfig.episodeId

	MoLiDeErController.instance:dispatchEvent(MoLiDeErEvent.OnClickEpisodeItem, self.index, episodeId)
end

function MoLiDeErLevelItem:_editableInitView()
	self._starItemDic = {}
	self._starItemParentList = {}
	self._starAnimGoList = {}

	local parent = self._gostar.transform
	local childCount = parent.childCount

	for i = 1, childCount do
		local starTran = parent:GetChild(i - 1).transform
		local starAnimGo = gohelper.findChild(starTran.gameObject, "has/#Star_ani")

		table.insert(self._starItemParentList, starTran)

		local nodeChildCount = starTran.childCount
		local starNodeStateDic = {}

		for j = 1, nodeChildCount do
			local stateGo = starTran:GetChild(j - 1).gameObject

			table.insert(starNodeStateDic, stateGo)
		end

		table.insert(self._starItemDic, starNodeStateDic)
		table.insert(self._starAnimGoList, starAnimGo)
	end

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function MoLiDeErLevelItem:setData(index, config)
	self.index = index
	self.actId = MoLiDeErModel.instance:getCurActId()
	self.episodeId = config.episodeId
	self.preEpisodeId = config.preEpisodeId
	self.episodeConfig = config
end

function MoLiDeErLevelItem:refreshUI(playAnim)
	local episodeInfo = MoLiDeErModel.instance:getEpisodeInfoMo(self.actId, self.episodeId)
	local config = self.episodeConfig
	local isComplete = episodeInfo:isComplete()
	local index = self.index

	if isComplete then
		if not MoLiDeErEnum.LevelItemTitleColor.Complete then
			local textColor = MoLiDeErEnum.LevelItemTitleColor.NoComplete

			self._txtstagename.text = string.format("<color=%s>%s</color>", textColor, config.name)
			textColor = isComplete and MoLiDeErEnum.LevelItemStateNameColor.Complete or MoLiDeErEnum.LevelItemStateNameColor.NoComplete

			local indexText = index >= 10 and tostring(index) or "0" .. tostring(index)

			self._txtstageNum.text = string.format("<color=%s>STAGE %s</color>", textColor, indexText)

			gohelper.setActive(self._gostagefinish, isComplete)
			gohelper.setActive(self._goCurrent, false)

			if isComplete then
				if not MoLiDeErEnum.LevelState.Complete then
					local state = MoLiDeErEnum.LevelState.Unlock
					local suffix = tostring(state)

					UISpriteSetMgr.instance:setMoLiDeErSprite(self._imagepoint, "v2a8_molideer_game_stage_point_" .. suffix)
					UISpriteSetMgr.instance:setMoLiDeErSprite(self._imagepointFinish, "v2a8_molideer_game_stage_point_" .. suffix)
					self:setStarState(playAnim)
					self:setAnimState(state, playAnim)
				end
			end
		end
	end
end

function MoLiDeErLevelItem:setActive(active)
	gohelper.setActive(self.viewGO, active)
end

function MoLiDeErLevelItem:setAnimState(state, playAnim)
	if state == MoLiDeErEnum.LevelState.Complete then
		if not MoLiDeErEnum.AnimName.LevelItemFinish then
			local animName = MoLiDeErEnum.AnimName.LevelItemUnlock
			local animTime = playAnim and 0 or 1

			self._animator:Play(animName, 0, animTime)
		end
	end
end

function MoLiDeErLevelItem:setStarState(playAnim)
	local episodeInfo = MoLiDeErModel.instance:getEpisodeInfoMo(self.actId, self.episodeId)
	local config = self.episodeConfig
	local star = episodeInfo.passStar
	local maxStar = (config.gameId == nil or config.gameId == 0) and 1 or 2
	local starItemList = self._starItemDic
	local starAnimGoList = self._starAnimGoList
	local count = #starItemList

	for i = 1, count do
		local isPass = i <= star
		local isAdd = self._previousStar == nil or i > self._previousStar and star > self._previousStar
		local stateList = starItemList[i]
		local starAnimGo = starAnimGoList[i]

		gohelper.setActive(stateList[1], not isPass)
		gohelper.setActive(stateList[2], isPass)
		gohelper.setActive(starAnimGo, isPass and isAdd and playAnim)
	end

	if maxStar < count then
		for i = maxStar + 1, count do
			local parentGo = self._starItemParentList[i]

			gohelper.setActive(parentGo, false)
		end
	end

	self._previousStar = star
end

function MoLiDeErLevelItem:setFocus(active)
	gohelper.setActive(self._goCurrent, active)
end

function MoLiDeErLevelItem:onDestroy()
	return
end

return MoLiDeErLevelItem
