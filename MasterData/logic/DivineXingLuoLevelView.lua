-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yishichallenge/view/DivineXingLuoLevelView.lua

module("logic.extensions.yishichallenge.view.DivineXingLuoLevelView", package.seeall)

local DivineXingLuoLevelView = class("DivineXingLuoLevelView", YishiChallengeLevelView)

function DivineXingLuoLevelView:ctor()
	DivineXingLuoLevelView.super.ctor(self)
end

function DivineXingLuoLevelView:onEnter()
	DivineXingLuoLevelView.super.onEnter(self)
	YishiChallengeControll.instance:stopEffect()
end

function DivineXingLuoLevelView:_tipsOnClick()
	UIStateManager.instance:push(ViewName.RulesView, "DivineXingLuoRule_2")
end

function DivineXingLuoLevelView:_updateLevelCell(view, cell, data)
	local txtLevel = goutil.findChildTextComponent(cell, "root/txtLevel")
	local xPos = data.pos[1]
	local yPos = data.pos[2]
	local root = goutil.findChild(cell, "root")

	GameUtil.setAnchoredPos(root, xPos, yPos)

	local mask = goutil.findChild(cell, "root/mask")
	local pass = goutil.findChild(cell, "root/mask/pass")
	local lock = goutil.findChild(cell, "root/mask/lock")

	if self._curStageId == data.stageId then
		goutil.setActive(mask, false)

		if self._stageUnlock then
			goutil.setActive(pass, data.isOver)
			goutil.setActive(mask, data.isOver)
		end
	else
		goutil.setActive(mask, true)
		goutil.setActive(pass, data.isOver)
		goutil.setActive(lock, not data.isOver)
	end

	txtLevel.text = string.format("第<Size=40>%s</size>关", data.stageId)
end

return DivineXingLuoLevelView
