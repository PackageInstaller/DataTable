-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeNode.lua

local ResMazeNodeConfig = require("ClientData/ResMazeNodeConfig")
local ResClientNotice = require("ClientData/ResClientNotice")
local strClassName = "MazeNode"
local MazeNode = Class(strClassName)
local STATE = {
	now = 2,
	will = 3,
	done = 1
}
local COFNIG_LINE = {
	"_node_line_001",
	"_node_line_002"
}
local BOX_NODE = 6

function MazeNode:ctor(parent, nodeCom, id)
	self.mParent = parent
	self.nodeCom = nodeCom
	self.id = id
	self.state = STATE.will
	self.mActive = true
	self.picMap = {}
end

function MazeNode:setPlateScaleX(scale)
	self.nodeCom:SetPlateScaleX(scale)
end

function MazeNode:setClick(...)
	if self.state == STATE.done then
		MsgManager.notice(Lang.get(724))

		return
	elseif self.state == STATE.will then
		if self.boxNode then
			self:openNodeUI(true)
		else
			MsgManager.notice(Lang.get(30591))

			return
		end
	else
		local relics = CurAvatar.mazeData.relics_cache

		if relics and #relics > 0 then
			local function _chooseHallow(...)
				UIManager.getUI("mazeHallowChooseDlg", true):show(relics)
			end

			UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", ResClientNotice[158].notice, _chooseHallow, Lang.get(30592))

			return
		end

		self.mParent:setSelectNode(self.id, Slot(self.openNodeUI, self))
	end
end

function MazeNode:isChangeNode(...)
	return self:_getNodeType() == 11
end

function MazeNode:openNodeUI(ispreView)
	if not GameFsm.isInState(Const.STATE_MAIN_MAZE) then
		return
	end

	local isFirstPass = CurAvatar:isMazeFirstPass()

	if self.state == STATE.will then
		local preView = self.boxNode

		UIManager.getUI("mazeInfoLvDlg", true):show(self.data.base, self.id, preView, false)
	elseif self.state == STATE.now then
		if self.mParent:isFinalLayerAndNode(self.id) then
			UIManager.getUI("mazeFinishDlg", true):setData(self.data.base.branchs[1], 1, self.data.base, isFirstPass)
		elseif self:isChangeNode() then
			RPC.mazeSelectBranch(1)

			CurAvatar.showMazeChange = true
		else
			local showFirstPass = self.mParent:isNextNodeChange(self.id)

			UIManager.getUI("mazeInfoLvDlg", true):show(self.data.base, self.id, false, showFirstPass)
		end
	end
end

function MazeNode:setData(data)
	self.data = data
	self.type = self:_getNodeType()

	if #self.data.base.branchs == 1 and self.type == BOX_NODE then
		self.boxNode = true

		self:addBoxEffect()
	end

	local scale = ResMazeNodeConfig[self.type].node_scale

	self:setPlateScaleX(scale)
end

function MazeNode:refreshState(...)
	if self.mParent.curNodeId < self.id then
		self.state = STATE.will
	elseif self.mParent.curNodeId == self.id then
		self.state = STATE.now
	else
		self.state = STATE.done
	end

	self:setNodeState(self.state)
	self:refreshBoxEffectVisible()
end

function MazeNode:getMazePrefix(...)
	if self.data.base.maze_back_tex then
		return string.sub(self.data.base.maze_back_tex, 1, 6)
	end

	if CurAvatar.mazeData then
		if CurAvatar.mazeData.maze_id < 10 then
			return "Maze0" .. CurAvatar.mazeData.maze_id
		else
			return "Maze" .. CurAvatar.mazeData.maze_id
		end
	else
		return ""
	end
end

function MazeNode:_getNodeType(...)
	local nodeType = 50

	if #self.data.base.branchs == 1 then
		nodeType = self.data.base.branchs[1].type
	end

	return nodeType
end

function MazeNode:setNodeState(state)
	if self.nodeCom then
		local nodeType = self:_getNodeType()
		local suffix = ""
		local lineIndex = 1

		if state == STATE.done then
			suffix = "_DIS"
			lineIndex = 1
		elseif state == STATE.now then
			suffix = "_NML"
			lineIndex = 2
		elseif state == STATE.will then
			suffix = "_SEL"
			lineIndex = 2
		end

		self:_setNodePic("SetNodeTypePic", ResMazeNodeConfig[nodeType].node_pic .. suffix)
		self:_setNodePic("SetNodeBack", self.data.base.maze_back_tex .. suffix)
		self:_setNodePic("SetNodeLine", self:getMazePrefix() .. COFNIG_LINE[lineIndex])
	end
end

function MazeNode:_checkUrl(funcName, url)
	if funcName == "SetNodeLine" then
		return "Textures/Maze/" .. url .. ".tga"
	else
		return "Textures/Maze/" .. url .. ".bmp"
	end
end

function MazeNode:_setNodePic(funcName, url)
	url = self:_checkUrl(funcName, url)

	if self.picMap[funcName] == nil or self.picMap[funcName] ~= url then
		self.picMap[funcName] = url

		self.nodeCom[funcName](self.nodeCom, url)
	end
end

function MazeNode:getPos(...)
	if self.nodeCom then
		return self.nodeCom.transform.position
	end
end

function MazeNode:addBoxEffect(...)
	if self.boxEffectId then
		return
	end

	local instId, controller = EffectManager:loadLogicEffect("Effects/maze/efx_Scene_BoxReward.prefab")

	self.boxEffectId = instId

	if controller then
		local conTransform = controller.gameObject.transform

		conTransform.parent = self.nodeCom.transform

		controller:SetNormalEffect(self.nodeCom.transform, "", Vector3(-0.123, 0.026, 0.252), Vector3(-22.4, 0, 0), 0)
		controller:SetLayer("Effect")
		controller:TurnOn()

		self.boxEffectGo = controller.gameObject
	end
end

function MazeNode:refreshBoxEffectVisible(...)
	if self.boxEffectGo and not tolua.isnull(self.boxEffectGo) then
		if self.state == STATE.will then
			self.boxEffectGo:SetActive(true)
		else
			self.boxEffectGo:SetActive(false)
		end
	end
end

function MazeNode:destroy(...)
	self.nodeCom = nil
	self.boxEffectGo = nil

	if self.boxEffectId then
		EffectManager:releaseEffect(self.boxEffectId)

		self.boxEffectId = nil
	end
end

return MazeNode
