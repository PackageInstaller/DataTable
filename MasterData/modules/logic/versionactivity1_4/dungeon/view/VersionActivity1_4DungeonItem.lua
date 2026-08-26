-- chunkname: @modules/logic/versionactivity1_4/dungeon/view/VersionActivity1_4DungeonItem.lua

module("modules.logic.versionactivity1_4.dungeon.view.VersionActivity1_4DungeonItem", package.seeall)

local VersionActivity1_4DungeonItem = class("VersionActivity1_4DungeonItem", LuaCompBase)

function VersionActivity1_4DungeonItem:init(go)
	self.viewGO = go
	self._imagepoint = gohelper.findChildImage(self.viewGO, "#image_point")
	self._imageline = gohelper.findChildImage(self.viewGO, "#image_line")
	self._goUnlock = gohelper.findChild(self.viewGO, "unlock")
	self._imagestagefinish = gohelper.findChildImage(self.viewGO, "unlock/#go_stagefinish")
	self._txtstagename = gohelper.findChildText(self.viewGO, "unlock/info/#txt_stagename")
	self._txtstagenum = gohelper.findChildText(self.viewGO, "unlock/info/#txt_stageNum")
	self._stars = {}

	for i = 1, 1 do
		local star = self:getUserDataTb_()

		star.index = i
		star.go = gohelper.findChild(self.viewGO, "unlock/info/#go_star" .. i)
		star.has = gohelper.findChild(star.go, "has")
		star.no = gohelper.findChild(star.go, "no")

		table.insert(self._stars, star)
	end

	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "unlock/#btn_click")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function VersionActivity1_4DungeonItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function VersionActivity1_4DungeonItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function VersionActivity1_4DungeonItem:_btnclickOnClick()
	if not self._config then
		return
	end

	local isOpen = DungeonModel.instance:isCanChallenge(self._config)

	if isOpen then
		VersionActivity1_4DungeonModel.instance:setSelectEpisodeId(self._config.id)
		ViewMgr.instance:openView(ViewName.VersionActivity1_4DungeonEpisodeView, {
			episodeId = self._config.id
		})
	else
		GameFacade.showToast(ToastEnum.V1a4_act130EpisodeNotUnlock)
	end
end

function VersionActivity1_4DungeonItem:refreshItem(co, index)
	self._config = co

	if not co then
		gohelper.setActive(self.viewGO, false)

		return
	end

	TaskDispatcher.cancelTask(self.playAnim, self)
	gohelper.setActive(self.viewGO, true)

	local isOpen = DungeonModel.instance:isCanChallenge(co)

	gohelper.setActive(self._goUnlock, isOpen)
	UISpriteSetMgr.instance:setV1a4Role37Sprite(self._imagepoint, isOpen and "v1a4_dungeon_stagebase2" or "v1a4_dungeon_stagebase1")
	UISpriteSetMgr.instance:setV1a4Role37Sprite(self._imageline, "v1a4_dungeon_stagebaseline2")
	gohelper.setActive(self._imageline, isOpen)

	local playUnlock = false

	if isOpen then
		self._txtstagename.text = co.name
		self._txtstagenum.text = GameUtil.fillZeroInLeft(index, 2)

		local episodeMO = DungeonModel.instance:getEpisodeInfo(co.id)

		if episodeMO then
			if not episodeMO.star then
				local star = 0

				for k, v in pairs(self._stars) do
					gohelper.setActive(v.has, star >= v.index)
					gohelper.setActive(v.no, star < v.index)
				end

				local isPass = DungeonModel.instance:hasPassLevel(co.id)

				UISpriteSetMgr.instance:setV1a4Role37Sprite(self._imagestagefinish, index == 5 and (isPass and "v1a4_dungeon_stagebg3" or "v1a4_dungeon_stagebg4") or isPass and "v1a4_dungeon_stagebg1" or "v1a4_dungeon_stagebg2")

				local aniState = VersionActivity1_4DungeonModel.instance:getEpisodeState(co.id)

				if isPass then
					if aniState < 2 then
						self.animName = "finish"

						self:playAnim()
					else
						self.animName = "open"

						self:playAnim()
					end
				elseif aniState < 1 then
					gohelper.setActive(self.viewGO, false)

					self.animName = "unlock"

					TaskDispatcher.runDelay(self.playAnim, self, 1.67)

					playUnlock = true
				else
					self.animName = "open"

					self:playAnim()
				end
			end
		end
	end

	return playUnlock, isOpen
end

function VersionActivity1_4DungeonItem:playAnim()
	gohelper.setActive(self.viewGO, true)
	self._animator:Play(self.animName)

	if self.animName == "unlock" then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_deblockingmap)
		VersionActivity1_4DungeonModel.instance:setEpisodeState(self._config.id, 1)
	elseif self.animName == "finish" then
		VersionActivity1_4DungeonModel.instance:setEpisodeState(self._config.id, 2)
	end
end

function VersionActivity1_4DungeonItem:onDestroy()
	TaskDispatcher.cancelTask(self.playAnim, self)
	self:removeEventListeners()
	self:__onDispose()
end

return VersionActivity1_4DungeonItem
