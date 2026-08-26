-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiDialogRoleRightItem.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogRoleRightItem", package.seeall)

local AergusiDialogRoleRightItem = class("AergusiDialogRoleRightItem", LuaCompBase)

function AergusiDialogRoleRightItem:init(go, path)
	self.go = go
	self._resPath = path
	self._golight = gohelper.findChild(go, "light")
	self._gochess = gohelper.findChild(go, "#chessitem")
	self._simagechess = gohelper.findChildSingleImage(go, "#chessitem/#chess")
	self._gotalk = gohelper.findChild(go, "go_talking")
	self._gobubble = gohelper.findChild(go, "go_bubble")
	self._gospeakbubble = gohelper.findChild(go, "go_bubble/go_speakbubble")
	self._txtspeakbubbledesc = gohelper.findChildText(go, "go_bubble/go_speakbubble/txt_dec")
	self._gothinkbubble = gohelper.findChild(go, "go_bubble/go_thinkbubble")
	self._txtthinkbubbledesc = gohelper.findChildText(go, "go_bubble/go_thinkbubble/txt_dec")
	self._goemo = gohelper.findChild(go, "emobg")
	self._chessAni = self._gochess:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self.go, true)
	gohelper.setActive(self._golight, false)
	gohelper.setActive(self._gotalk, false)
	gohelper.setActive(self._gobubble, false)
	gohelper.setActive(self._goemo, false)
	self._simagechess:LoadImage(ResUrl.getV2a1AergusiSingleBg(self._resPath))
end

function AergusiDialogRoleRightItem:showTalking()
	self._chessAni:Play("jump", 0, 0)
	gohelper.setActive(self._golight, true)
	gohelper.setActive(self._gotalk, true)
	TaskDispatcher.runDelay(self.hideTalking, self, 3)
end

function AergusiDialogRoleRightItem:hideTalking()
	TaskDispatcher.cancelTask(self.hideTalking, self)
	gohelper.setActive(self._gotalk, false)
	gohelper.setActive(self._golight, false)
end

function AergusiDialogRoleRightItem:showEmo()
	gohelper.setActive(self._goemo, true)
end

function AergusiDialogRoleRightItem:showBubble(bubbleCo)
	gohelper.setActive(self._gobubble, true)

	if bubbleCo.bubbleType == AergusiEnum.DialogBubbleType.Speaker then
		gohelper.setActive(self._gospeakbubble, true)
		gohelper.setActive(self._gothinkbubble, false)

		self._txtspeakbubbledesc.text = bubbleCo.content
	else
		gohelper.setActive(self._gothinkbubble, true)
		gohelper.setActive(self._gospeakbubble, false)

		self._txtthinkbubbledesc.text = bubbleCo.content
	end
end

function AergusiDialogRoleRightItem:hideBubble()
	gohelper.setActive(self._gobubble, false)
end

function AergusiDialogRoleRightItem:destroy()
	self._simagechess:UnLoadImage()
end

return AergusiDialogRoleRightItem
