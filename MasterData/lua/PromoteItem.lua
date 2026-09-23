--跳转推荐
function Refresh(_data)
    if _data then
        this.data=_data;
        if this.data:GetImg() then
            ResUtil.StoreAd:Load(bg,this.data:GetImg());
        end
    end
end

function OnClickGO()
    if this.data and this.data:GetJumpID() then
        JumpMgr:Jump(this.data:GetJumpID())
    end
end