function SetClickCB(_cb)
	cb = _cb
end

function Refresh(_info)
	info = _info
	local lvCfg = Cfgs.CfgDormRoom:GetByID(info.lv)
	--name
	CSAPI.SetText(txtSerial, info.cfg.roomName)
	--num
	CSAPI.SetGOActive(txtRole, info.isOpen)
	if(info.isOpen) then
		CSAPI.SetText(txtRole, string.format("%s/%s", info.roleNum, lvCfg.maxRole))
	end
	--lock
	CSAPI.SetGOActive(lock, not info.isOpen)
	--red
	UIUtil:SetRedPoint(clickNode, info.isRed, 100, 60, 0)
	--lv
	local lvStr = LanguageMgr:GetByID(1033) or "LV."
	local lvStr = info.isOpen and lvStr .. info.lv or ""
	CSAPI.SetText(txtLv, lvStr)
end

function OnClick()
	if(info.isOpen) then
		if(cb) then
			cb(info.id)
		end
	else
		--解锁房间
		local costs = info.cfg.costs
		if(costs) then
			local cost = costs[1]
			local cfg = Cfgs.ItemInfo:GetByID(cost[1])
			local desc = LanguageMgr:GetByID(32001, cost[2], cfg.name)
			UIUtil:OpenPoputSpendView(32000, desc, cost[1], function()
				DormProto:Open(info.id)
			end)
		end
	end
end

function OnDestroy()	
	ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	txtSerial = nil;
	txtRole = nil;
	lock = nil;
	txtLock = nil;
	view = nil;
end
----#End#----
