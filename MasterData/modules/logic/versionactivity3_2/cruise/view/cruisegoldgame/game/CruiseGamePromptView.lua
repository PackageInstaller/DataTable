-- chunkname: @modules/logic/versionactivity3_2/cruise/view/cruisegoldgame/game/CruiseGamePromptView.lua

module("modules.logic.versionactivity3_2.cruise.view.cruisegoldgame.game.CruiseGamePromptView", package.seeall)

local CruiseGamePromptView = class("CruiseGamePromptView", BaseView)

function CruiseGamePromptView:onInitView()
	self.txt_text = gohelper.findChildTextMesh(self.viewGO, "#txt_text")
end

function CruiseGamePromptView:addEvents()
	return
end

function CruiseGamePromptView:onOpen()
	self.viewParam.tipStr = self.viewParam.tipStr
	self.txt_text.text = self.viewParam.tipStr
end

function CruiseGamePromptView:onClose()
	return
end

function CruiseGamePromptView:onDestroyView()
	return
end

return CruiseGamePromptView
