-- chunkname: @modules/logic/stresstip/controller/StressTipController.lua

module("modules.logic.stresstip.controller.StressTipController", package.seeall)

local StressTipController = class("StressTipController", BaseController)

function StressTipController:openMonsterStressTip(monsterCo, clickPosition)
	ViewMgr.instance:openView(ViewName.StressTipView, {
		openEnum = StressTipView.OpenEnum.Monster,
		co = monsterCo,
		clickPosition = clickPosition or UnityEngine.Input.mousePosition
	})
end

function StressTipController:openHeroStressTip(heroCo, clickPosition)
	ViewMgr.instance:openView(ViewName.StressTipView, {
		openEnum = StressTipView.OpenEnum.Hero,
		co = heroCo,
		clickPosition = clickPosition or UnityEngine.Input.mousePosition
	})
end

function StressTipController:openAct183StressTip(identityIdList, clickPosition)
	ViewMgr.instance:openView(ViewName.StressTipView, {
		openEnum = StressTipView.OpenEnum.Act183,
		identityIdList = identityIdList,
		clickPosition = clickPosition or UnityEngine.Input.mousePosition
	})
end

StressTipController.instance = StressTipController.New()

return StressTipController
