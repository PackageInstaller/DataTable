-- chunkname: @modules/logic/endofdream/view/EndOfDreamView.lua

module("modules.logic.endofdream.view.EndOfDreamView", package.seeall)

local EndOfDreamView = class("EndOfDreamView", BaseView)

function EndOfDreamView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._golevelitem = gohelper.findChild(self.viewGO, "levelitemlist/#go_levelitem")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EndOfDreamView:addEvents()
	return
end

function EndOfDreamView:removeEvents()
	return
end

function EndOfDreamView:_levelitemOnClick(index)
	local levelItem = self._levelItemList[index]
	local unlock = EndOfDreamModel.instance:isLevelUnlocked(levelItem.levelId)

	if unlock then
		self:_changeSelectLevel(levelItem.levelId)
	end
end

function EndOfDreamView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_beijingtu.jpg"))
	gohelper.setActive(self._golevelitem, false)

	self._levelItemList = {}
	self._selectLevelId = nil
	self._selectEpisodeId = nil
	self._isHard = false
end

function EndOfDreamView:_changeSelectLevel(levelId)
	if levelId == self._selectLevelId then
		return
	end

	self._selectLevelId = levelId
	self._isHard = false

	local episodeConfig = EndOfDreamConfig.instance:getEpisodeConfigByLevelId(self._selectLevelId, self._isHard)

	self._selectEpisodeId = episodeConfig.id

	self:_refreshUI()
end

function EndOfDreamView:_changeSelectEpisode(episodeId)
	if episodeId == self._selectEpisodeId then
		return
	end

	self._selectEpisodeId = episodeId

	local levelConfig, isHard = EndOfDreamConfig.instance:getLevelConfigByEpisodeId(episodeId)

	self._selectLevelId = levelConfig.id
	self._isHard = isHard

	self:_refreshUI()
end

function EndOfDreamView:_changeHard(isHard)
	if isHard == self._isHard then
		return
	end

	self._isHard = isHard

	local episodeConfig = EndOfDreamConfig.instance:getEpisodeConfigByLevelId(self._selectLevelId, self._isHard)

	self._selectEpisodeId = episodeConfig.id

	self:_refreshUI()
end

function EndOfDreamView:_setDefaultSelect()
	if self.viewParam then
		local episodeId = self.viewParam.episodeId

		if self.viewParam then
			local levelId = self.viewParam.levelId

			if self.viewParam then
				local isHard = self.viewParam.isHard

				if episodeId then
					local levelConfig, _isHard = EndOfDreamConfig.instance:getLevelConfigByEpisodeId(episodeId)

					levelId = levelConfig.id
					isHard = _isHard
				end

				isHard = isHard or false
				self._isHard = isHard

				if levelId then
					self._selectLevelId = levelId
				else
					local firstLevelConfig = EndOfDreamConfig.instance:getFirstLevelConfig()

					self._selectLevelId = firstLevelConfig.id
				end

				local episodeConfig = EndOfDreamConfig.instance:getEpisodeConfigByLevelId(self._selectLevelId, self._isHard)

				self._selectEpisodeId = episodeConfig.id
			end
		end
	end
end

function EndOfDreamView:_refreshUI()
	self:_refreshLevel()
	self:_refreshInfo()
end

function EndOfDreamView:_refreshLevel()
	local levelConfigList = EndOfDreamConfig.instance:getLevelConfigList()

	for i, levelConfig in ipairs(levelConfigList) do
		local levelId = levelConfig.id
		local levelItem = self._levelItemList[i]

		if not levelItem then
			levelItem = self:getUserDataTb_()
			levelItem.index = i
			levelItem.go = gohelper.cloneInPlace(self._golevelitem, "item" .. i)
			levelItem.goselect = gohelper.findChild(levelItem.go, "go_selected")
			levelItem.txtselect = gohelper.findChildText(levelItem.go, "go_selected/txt_itemcn2")
			levelItem.gounselect = gohelper.findChild(levelItem.go, "go_unselected")
			levelItem.txtunselect = gohelper.findChildText(levelItem.go, "go_unselected/txt_itemcn1")
			levelItem.golock = gohelper.findChild(levelItem.go, "go_locked")
			levelItem.btnclick = gohelper.findChildButtonWithAudio(levelItem.go, "btn_click")

			levelItem.btnclick:AddClickListener(self._levelitemOnClick, self, levelItem.index)
			table.insert(self._levelItemList, levelItem)
		end

		levelItem.levelId = levelId
		levelItem.txtselect.text = levelConfig.name
		levelItem.txtunselect.text = levelConfig.name

		local unlock = EndOfDreamModel.instance:isLevelUnlocked(levelId)

		gohelper.setActive(levelItem.goselect, levelId == self._selectLevelId)
		gohelper.setActive(levelItem.gounselect, levelId ~= self._selectLevelId)
		gohelper.setActive(levelItem.golock, not unlock)
		gohelper.setActive(levelItem.go, true)
	end

	for i = #levelConfigList + 1, #self._levelItemList do
		local levelItem = self._levelItemList[i]

		gohelper.setActive(levelItem.go, false)
	end
end

function EndOfDreamView:_refreshInfo()
	return
end

function EndOfDreamView:onOpen()
	self:_setDefaultSelect()
	self:_refreshUI()
end

function EndOfDreamView:onClose()
	return
end

function EndOfDreamView:onDestroyView()
	for i, levelItem in ipairs(self._levelItemList) do
		levelItem.btnclick:RemoveClickListener()
	end
end

return EndOfDreamView
