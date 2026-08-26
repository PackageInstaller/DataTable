-- chunkname: @modules/logic/gm/view/GMFightStandardEpisodeForTestServerViewChapterItem.lua

module("modules.logic.gm.view.GMFightStandardEpisodeForTestServerViewChapterItem", package.seeall)

local GMFightStandardEpisodeForTestServerViewChapterItem = class("GMFightStandardEpisodeForTestServerViewChapterItem", FightBaseView)

function GMFightStandardEpisodeForTestServerViewChapterItem:onInitView()
	self.text = gohelper.findChildText(self.viewGO, "btn/Text")
	self.btn = gohelper.findChildButtonWithAudio(self.viewGO, "btn")
end

function GMFightStandardEpisodeForTestServerViewChapterItem:addEvents()
	self:com_registClick(self.btn, self.onClick)
end

function GMFightStandardEpisodeForTestServerViewChapterItem:onClick()
	self.PARENT_VIEW:onClickChapterItem(self.config)
end

function GMFightStandardEpisodeForTestServerViewChapterItem:removeEvents()
	return
end

function GMFightStandardEpisodeForTestServerViewChapterItem:onRefreshItemData(config)
	self.config = config
	self.text.text = config.name
end

function GMFightStandardEpisodeForTestServerViewChapterItem:onOpen()
	return
end

function GMFightStandardEpisodeForTestServerViewChapterItem:onClose()
	return
end

return GMFightStandardEpisodeForTestServerViewChapterItem
