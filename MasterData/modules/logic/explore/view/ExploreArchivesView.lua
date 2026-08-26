-- chunkname: @modules/logic/explore/view/ExploreArchivesView.lua

module("modules.logic.explore.view.ExploreArchivesView", package.seeall)

local ExploreArchivesView = class("ExploreArchivesView", BaseView)

function ExploreArchivesView:onInitView()
	self._txtChapter = gohelper.findChildTextMesh(self.viewGO, "title/txt_title/#txt_chapter")
	self._btneasteregg = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_easteregg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ExploreArchivesView:_editableInitView()
	self._content = gohelper.findChild(self.viewGO, "#scroll_list/Viewport/Content")
end

function ExploreArchivesView:addEvents()
	self._btneasteregg:AddClickListener(self._onEggClick, self)
end

function ExploreArchivesView:removeEvents()
	self._btneasteregg:RemoveClickListener()
end

function ExploreArchivesView:onOpen()
	self._images = {}

	local chapterId = self.viewParam.id
	local chapterMo = ExploreSimpleModel.instance:getChapterMo(chapterId)

	self.unLockArchives = chapterMo.archiveIds

	gohelper.setActive(self._btneasteregg, chapterMo:haveBonusScene())

	local configs = lua_explore_story.configDict[chapterId]

	if not configs then
		return
	end

	local newArchiveIds = ExploreSimpleModel.instance:getNewArchives(chapterId)
	local newArchiveIdsDict = {}

	for _, v in pairs(newArchiveIds) do
		newArchiveIdsDict[v] = true
	end

	self._txtChapter.text = DungeonConfig.instance:getChapterCO(chapterId).name

	ExploreSimpleModel.instance:markArchive(chapterId, false)

	local assetPath = string.format("ui/viewres/explore/explorearchivechapter%d.prefab", chapterId)
	local go = self:getResInst(assetPath, self._content)
	local trans = go.transform

	recthelper.setWidth(self._content.transform, recthelper.getWidth(trans))

	self._unLockAnims = {}

	for i = 0, trans.childCount - 1 do
		local child = trans:GetChild(i)
		local name = child.name
		local id = string.match(name, "^#go_item_(%d+)$")

		if id then
			self:_initArchiveItem(child, configs[tonumber(id)], newArchiveIdsDict)
		end
	end

	local lineTrans = trans:Find("line")

	if lineTrans then
		for i = 0, lineTrans.childCount - 1 do
			local child = lineTrans:GetChild(i)
			local name = child.name
			local id1, id2 = string.match(name, "^#go_line_(%d+)_(%d+)$")
			local isShow = false

			if id1 and id2 then
				isShow = self.unLockArchives[tonumber(id1)] and self.unLockArchives[tonumber(id2)]
			else
				id1, id2 = string.match(name, "^#go_line_gray_(%d+)_(%d+)$")
				isShow = not self.unLockArchives[tonumber(id1)] or not self.unLockArchives[tonumber(id2)]
			end

			gohelper.setActive(child, isShow)
		end
	end

	if #self._unLockAnims > 0 then
		TaskDispatcher.runDelay(self.beginUnlock, self, 1.1)
	end
end

function ExploreArchivesView:_onEggClick()
	ViewMgr.instance:openView(ViewName.ExploreBonusSceneRecordView, {
		chapterId = self.viewParam.id
	})
end

function ExploreArchivesView:_initArchiveItem(trans, config, newArchiveIdsDict)
	local go = trans.gameObject
	local click = gohelper.getClickWithAudio(go, AudioEnum.UI.play_ui_feedback_open)
	local image = gohelper.findChildSingleImage(go, "#simage_icon")
	local name = gohelper.findChildTextMesh(go, "#txt_name")
	local lock = gohelper.findChild(go, "#go_lock")
	local lock_image = gohelper.findChildSingleImage(go, "#go_lock/#simage_icon")
	local new = gohelper.findChild(go, "go_new")
	local lock_1 = gohelper.findChild(go, "#go_lock/lock")
	local lock_2 = gohelper.findChild(go, "#go_lock/cn")
	local lock_3 = gohelper.findChild(go, "#go_lock/en")
	local lock_anim = lock:GetComponent(typeof(UnityEngine.Animator))

	if not self.unLockArchives[config.id] then
		if not newArchiveIdsDict[config.id] then
			local isNew = false

			gohelper.setActive(image, self.unLockArchives[config.id])
			gohelper.setActive(name, self.unLockArchives[config.id])
			gohelper.setActive(lock, not self.unLockArchives[config.id])
			gohelper.setActive(new, isNew)

			name.text = config.title

			image:LoadImage(ResUrl.getExploreBg("file/" .. config.res))
			lock_image:LoadImage(ResUrl.getExploreBg("file/" .. config.res))
			table.insert(self._images, image)
			table.insert(self._images, lock_image)

			if self.unLockArchives[config.id] then
				self._goNew = self._goNew or self:getUserDataTb_()
				self._goNew[config.id] = new

				self.addClickCb(self, click, self._onItemClick, self, config.id)
			end

			if isNew then
				gohelper.setActive(lock, true)
				gohelper.setActive(name, false)
				gohelper.setActive(new, false)
				table.insert(self._unLockAnims, {
					lock,
					lock_anim,
					name,
					image,
					new,
					lock_1,
					lock_2,
					lock_3
				})
			end
		end
	end
end

function ExploreArchivesView:beginUnlock()
	for _, v in pairs(self._unLockAnims) do
		v[2]:Play("unlock", 0, 0)
		gohelper.setActive(v[6], false)
		gohelper.setActive(v[7], false)
		gohelper.setActive(v[8], false)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
	TaskDispatcher.runDelay(self.unlockEnd, self, 1)
end

function ExploreArchivesView:unlockEnd()
	for _, v in pairs(self._unLockAnims) do
		gohelper.setActive(v[1], false)
		gohelper.setActive(v[3], true)
		gohelper.setActive(v[4], true)
		gohelper.setActive(v[5], true)

		self._tweens = self._tweens or {}

		local tweenId = ZProj.TweenHelper.DoFade(v[3], 0, 1, 0.5)

		table.insert(self._tweens, tweenId)
	end
end

function ExploreArchivesView:_onItemClick(id)
	gohelper.setActive(self._goNew[id], false)
	ViewMgr.instance:openView(ViewName.ExploreArchivesDetailView, {
		id = id,
		chapterId = self.viewParam.id
	})
end

function ExploreArchivesView:onClose()
	TaskDispatcher.cancelTask(self.beginUnlock, self)
	TaskDispatcher.cancelTask(self.unlockEnd, self)

	for _, v in pairs(self._images) do
		v:UnLoadImage()
	end

	if self._tweens then
		for _, id in pairs(self._tweens) do
			ZProj.TweenHelper.KillById(id)
		end

		self._tweens = nil
	end
end

return ExploreArchivesView
