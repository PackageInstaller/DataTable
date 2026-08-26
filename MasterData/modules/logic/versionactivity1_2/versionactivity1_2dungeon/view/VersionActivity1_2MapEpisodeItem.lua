-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity1_2MapEpisodeItem.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2MapEpisodeItem", package.seeall)

local VersionActivity1_2MapEpisodeItem = class("VersionActivity1_2MapEpisodeItem", VersionActivity1_2MapEpisodeBaseItem)

function VersionActivity1_2MapEpisodeItem:onInitView()
	VersionActivity1_2MapEpisodeItem.super.onInitView(self)
end

function VersionActivity1_2MapEpisodeItem:getDungeonMapLevelView()
	return ViewName.VersionActivity1_2DungeonMapLevelView
end

function VersionActivity1_2MapEpisodeItem:_editableInitView()
	VersionActivity1_2MapEpisodeItem.super._editableInitView(self)
end

function VersionActivity1_2MapEpisodeItem:refreshFlag()
	local passStory = DungeonModel.instance:hasPassLevelAndStory(self._config.id)

	gohelper.setActive(self._goflag, not passStory)
end

function VersionActivity1_2MapEpisodeItem:_onStarItemShow(obj, data, index)
	local episodeId = data
	local advancedConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(episodeId)
	local episodeMo = DungeonModel.instance:getEpisodeInfo(episodeId)
	local image_star1 = gohelper.findChildImage(obj, "#image_star1")
	local image_star2 = gohelper.findChildImage(obj, "#image_star2")
	local is_hard = self:isDungeonHardModel()
	local _color

	if is_hard then
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(image_star1, "juqing_xing1_kn")
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(image_star2, "juqing_xing2_kn")

		_color = "#e43938"
	else
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(image_star1, "juqing_xing1")
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(image_star2, "juqing_xing2")

		if index == 1 then
			_color = "#e4b472"
		elseif index == 2 then
			_color = "#e7853d"
		elseif index == 3 then
			_color = "#ef3939"
		end
	end

	local _gray = "#949494"
	local pass = DungeonModel.instance:hasPassLevelAndStory(episodeId)

	SLFramework.UGUI.GuiHelper.SetColor(image_star1, pass and _color or _gray)

	if string.nilorempty(advancedConditionText) then
		gohelper.setActive(image_star2.gameObject, false)
	else
		gohelper.setActive(image_star2.gameObject, true)
		SLFramework.UGUI.GuiHelper.SetColor(image_star2, pass and episodeMo and episodeMo.star >= DungeonEnum.StarType.Advanced and _color or _gray)
	end
end

function VersionActivity1_2MapEpisodeItem:setImage(image, light, isHard)
	return
end

function VersionActivity1_2MapEpisodeItem:getMapCfg()
	return VersionActivity1_2DungeonConfig.instance:get1_2EpisodeMapConfig(self._config.id)
end

function VersionActivity1_2MapEpisodeItem:playAnimation(animationName)
	self.animator:Play(animationName, 0, 0)
end

function VersionActivity1_2MapEpisodeItem:getEpisodeId()
	return self._config and self._config.id
end

function VersionActivity1_2MapEpisodeItem:createStarItem(goStar)
	local starItem = self:getUserDataTb_()

	starItem.goStar = goStar
	starItem.imgStar1 = gohelper.findChildImage(goStar, "#image_star1")
	starItem.imgStar2 = gohelper.findChildImage(goStar, "#image_star2")

	return starItem
end

function VersionActivity1_2MapEpisodeItem:onClose()
	VersionActivity1_2MapEpisodeItem.super.onClose(self)
end

function VersionActivity1_2MapEpisodeItem:onDestroyView()
	VersionActivity1_2MapEpisodeItem.super.onDestroyView(self)
	self.goClick:RemoveClickListener()
end

return VersionActivity1_2MapEpisodeItem
