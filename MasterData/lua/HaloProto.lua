--光环协议
HaloProto={}

function HaloProto:HaloUp(cid,haloId,items)
	local proto = {"HaloProto:HaloUp", {cid=cid,haloId=haloId,items=items}}
	NetMgr.net:Send(proto);
end

function HaloProto:HaloUpRet(proto)
	EventMgr.Dispatch(EventType.Halo_Upgrade_Ret,proto);
	RoleMgr:CardHaloUpdate(proto)
end

function HaloProto:HaloChange(cid,hid)
    local proto = {"HaloProto:HaloChange", {cid=cid,hid=hid}}
	NetMgr.net:Send(proto);
end

function HaloProto:HaloChangeRet(proto)
	RoleMgr:CardHaloSwitch(proto)
end