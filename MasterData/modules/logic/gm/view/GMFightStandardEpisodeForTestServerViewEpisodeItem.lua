-- chunkname: @modules/logic/gm/view/GMFightStandardEpisodeForTestServerViewEpisodeItem.lua

module("modules.logic.gm.view.GMFightStandardEpisodeForTestServerViewEpisodeItem", package.seeall)

local GMFightStandardEpisodeForTestServerViewEpisodeItem = class("GMFightStandardEpisodeForTestServerViewEpisodeItem", FightBaseView)

function GMFightStandardEpisodeForTestServerViewEpisodeItem:onInitView()
	self.text = gohelper.findChildText(self.viewGO, "btn/Text")
	self.btn = gohelper.findChildButtonWithAudio(self.viewGO, "btn")
end

function GMFightStandardEpisodeForTestServerViewEpisodeItem:addEvents()
	self:com_registClick(self.btn, self.onClick)
end

function GMFightStandardEpisodeForTestServerViewEpisodeItem:onClick()
	if DungeonModel.isBattleEpisode(self.config) then
		JumpModel.instance.jumpFromFightSceneParam = "99"

		DungeonFightController.instance:enterFight(self.config.chapterId, self.config.id)
	else
		logError("GMToolView 不支持该类型的关卡" .. self.config.id)
	end

	ViewMgr.instance:closeView(ViewName.GMFightStandardEpisodeForTestServerView)
end

function GMFightStandardEpisodeForTestServerViewEpisodeItem:removeEvents()
	return
end

function GMFightStandardEpisodeForTestServerViewEpisodeItem:onRefreshItemData(config)
	self.config = config
	self.text.text = config.name
end

function GMFightStandardEpisodeForTestServerViewEpisodeItem:onOpen()
	return
end

function GMFightStandardEpisodeForTestServerViewEpisodeItem:onClose()
	return
end

return GMFightStandardEpisodeForTestServerViewEpisodeItem
