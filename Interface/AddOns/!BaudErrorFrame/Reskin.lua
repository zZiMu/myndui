local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function()
	f:UnregisterEvent("PLAYER_ENTERING_WORLD")
	if IsAddOnLoaded("Aurora") then
		local F = unpack(Aurora)
		F.ReskinScroll(BaudErrorFrameListScrollBoxScrollBarScrollBar)
		F.ReskinScroll(BaudErrorFrameDetailScrollFrameScrollBar)
	end
	if IsAddOnLoaded("NDui") then
		local B = unpack(NDui)
		B.CreateBD(BaudErrorFrame)
		B.CreateTex(BaudErrorFrame)
		B.CreateSD(BaudErrorFrame, 1, 4)
		local BG2 = CreateFrame("Frame", nil, BaudErrorFrame)
		BG2:SetPoint("CENTER", BaudErrorFrame, "CENTER", 0, -81)
		BG2:SetSize(BaudErrorFrameEditBox:GetWidth() + 60, BaudErrorFrameEditBox:GetHeight() + 15)
		B.CreateBD(BG2)
		B.CreateBD(BaudErrorFrameClearButton)
		B.CreateBC(BaudErrorFrameClearButton)
		B.CreateBD(BaudErrorFrameCloseButton)
		B.CreateBC(BaudErrorFrameCloseButton)
		B.CreateBD(BaudErrorFrameReloadUIButton)
		B.CreateBC(BaudErrorFrameReloadUIButton)
	end
end)