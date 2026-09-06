-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/xingluo/XingluolevelsView.lua

module("logic.extensions.lailisi.view.xingluo.XingluolevelsView", package.seeall)

local XingluolevelsView = class("XingluolevelsView", LailisilevelsView)

function XingluolevelsView:_onClickChallenge(data)
	CustomFmtController.instance:showMissionView(XingluoFinghtMo.instance:getCustomFmtMo(self._curActId, data.stageId))
end

return XingluolevelsView
