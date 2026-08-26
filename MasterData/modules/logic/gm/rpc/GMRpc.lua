-- chunkname: @modules/logic/gm/rpc/GMRpc.lua

module("modules.logic.gm.rpc.GMRpc", package.seeall)

local GMRpc = class("GMRpc", BaseRpc)

function GMRpc:sendGMRequest(commandText, callback, callbackObj)
	local req = GMModule_pb.GMRequest()

	logNormal("sendGMRequest: " .. commandText)

	req.commandText = commandText
	self.callback = callback
	self.callbackObj = callbackObj

	self:sendMsg(req)
end

function GMRpc:onReceiveGMReply(resultCode, msg)
	if self.callback then
		if self.callbackObj then
			self.callback(self.callbackObj)
		else
			self.callback()
		end

		self.callback = nil
		self.callbackObj = nil
	end

	if isDebugBuild then
		if msg.result == 1 then
			ToastController.instance:showToastWithString("GM 执行失败")
		elseif msg.result == 2 then
			ToastController.instance:showToastWithString("GM 命令不存在")
		end
	end

	GMController.instance:dispatchEvent(GMController.Event.OnRecvGMMsg)
end

function GMRpc:sendGpuCpuLogRequest(cpu, gpu)
	local req = GMModule_pb.GpuCpuLogRequest()

	req.cpu = cpu
	req.gpu = gpu

	self:sendMsg(req)
end

function GMRpc:onReceiveGpuCpuLogReply(resultCode, msg)
	return
end

function GMRpc:onReceiveTestGMTextReply(resultCode, msg)
	GMBattleModel.instance:setBattleParam(msg.text)
end

function GMRpc:onReceiveGMSummonResultPush(resultCode, msg)
	GMSummonModel.instance:setInfo(msg)

	if not ViewMgr.instance:isOpen(ViewName.GMSummonView) then
		ViewMgr.instance:openView(ViewName.GMSummonView)
	end
end

function GMRpc:onReceiveFightTipsMessagePush(resultCode, msg)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	logError("FightTipsMessagePush: " .. msg.msg)
end

function GMRpc:onReceiveServerErrorInfoPush(resultCode, msg)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	if msg.isAlert then
		MessageBoxController.instance:showMsgBoxByStr("服务器报错了: " .. msg.msg, MsgBoxEnum.BoxType.Yes)
	else
		ToastController.instance:showToastWithString("服务器报错了，看一下Console！")
		logError("服务器报错了: " .. msg.msg)
	end
end

function GMRpc:sendGmModuleRequest(callback, callbackObj)
	local req = GMModule_pb.GmModuleRequest()

	self:sendMsg(req, callback, callbackObj)
end

function GMRpc:onReceiveGmModuleReply(resultCode, msg)
	return
end

GMRpc.instance = GMRpc.New()

return GMRpc
