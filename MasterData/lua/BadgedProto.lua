BadgedProto = {}

--获取徽章的数据
function BadgedProto:GetBadgedInfo()
    local proto = {"BadgedProto:GetBadgedInfo", {}};
	NetMgr.net:Send(proto);
end

function BadgedProto:GetBadgedInfoRet(proto)
    -- Log("BadgedProto:GetBadgedInfoRet")
    -- Log(proto)
    BadgeMgr:SetDatas(proto)
end

--去除new标识
function BadgedProto:UpdateBadged(list)
    local proto = {"BadgedProto:UpdateBadged", {ids = list}};
	NetMgr.net:Send(proto);
end

--获取徽章的排序
function BadgedProto:GetSortBadgedInfo()
    local proto = {"BadgedProto:GetSortBadgedInfo", {}};
	NetMgr.net:Send(proto);
end

function BadgedProto:GetSortBadgedInfoRet(proto)
    -- Log("BadgedProto:GetSortBadgedInfoRet")
    -- Log(proto)
    BadgeMgr:SetSorts(proto)
    if self.updateSortBadgedCallback then
        self.updateSortBadgedCallback()
        self.updateSortBadgedCallback = nil
    end
end

--修改徽章的顺序 
function BadgedProto:UpdateSortBadged(list,cb)
    local proto = {"BadgedProto:UpdateSortBadged", {pos = list}};
	NetMgr.net:Send(proto);
    self.updateSortBadgedCallback = cb
end

--徽章信息刷新
function BadgedProto:UpdateBadgedInfoRet(proto)
    BadgeMgr:UpdateBadgedInfo(proto)
end