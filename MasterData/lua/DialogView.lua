
function Awake()    
    txtContent = ComUtil.GetCom(goTxtContent,"Text");
end

function OnOpen()
    if(data ~= nil)then
       txtContent.text = data.content or "";
    end
end

function OnClickOK()
    if(data ~= nil and data.okCallBack ~= nil)then
        data.okCallBack(data.caller);
    end
    data = nil;
view:Close();
end

function OnClickCancel()
    if(data ~= nil and data.cancelCallBack ~= nil)then
        data.cancelCallBack(data.caller);
    end
    data = nil;
    view:Close();
end


function OnClickClose()    
    data = nil;
    view:Close();
end
