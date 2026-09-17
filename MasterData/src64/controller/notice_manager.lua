local var_0_0 = {
	data = {}
}
local network = require("network.network")
local account_manager = require("controller.account_manager")
local playermodel = require("model.playermodel")

function var_0_0:getCurNoticeStatus()
	return self.data or {}
end

function var_0_0.setCurNoticeStatus(arg_2_0, arg_2_1)
	network:rpc("get_notice_id", {
		channelid = account_manager:getChannel()
	}, function(arg_3_0)
		if arg_3_0.result == 1 then
			arg_2_0.data = arg_3_0.notice_tbl or {}

			if arg_2_1 then
				arg_2_1(arg_2_0.data)
			end
		end
	end)
end

function var_0_0:check_new_notice()
	network:rpc("get_backend_notice_version", nil, function(arg_5_0)
		print("Test Check New Notice: ", dump(arg_5_0))

		local var_5_0 = cc.EventCustom:new("NEWNOTICE")

		var_5_0.isnew = arg_5_0.isnew

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_5_0)
	end)

	if not self.url then
		self:get_notice_url_from_server()
	end
end

function var_0_0.update_notice_version(arg_6_0)
	network:rpc("update_backend_notice_version")
end

var_0_0.url = nil

function var_0_0.get_notice_url_from_server(arg_7_0)
	network:rpc("get_notice_url", nil, function(arg_8_0)
		arg_7_0.url = arg_8_0.url
	end)
end

function var_0_0:get_notice_url()
	if DeviceManager.getChannelID() == "270057" then
		local account_manager = require("controller.account_manager")

		return (string.format("http://horcruxgm.aojiaostudio.com/noticeSite/newsList.html?server=%d&channel=%s", account_manager:getServerID() or 1, account_manager:getChannel()))
	end

	if self.url then
		return (string.gsub(string.gsub(self.url, "{channel}", account_manager:getChannel()), "{playerid}", playermodel.playerid))
	else
		self:get_notice_url_from_server()

		return nil
	end
end

return var_0_0
