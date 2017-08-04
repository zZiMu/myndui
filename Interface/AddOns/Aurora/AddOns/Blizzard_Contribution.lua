local F, C = unpack(select(2, ...))

C.themes["Blizzard_Contribution"] = function()
	local r, g, b = C.r, C.g, C.b

	local frame = ContributionCollectionFrame
	F.SetBD(frame)
	F.ReskinClose(frame.CloseButton)
	frame.CloseButton.CloseButtonBackground:Hide()
	frame.Background:Hide()

	hooksecurefunc(ContributionMixin, "Update", function(self)
		if not self.styled then
			self.Header.Text:SetTextColor(1, .8, 0)
			F.Reskin(self.ContributeButton)

			self.styled = true
		end
	end)

	hooksecurefunc(ContributionRewardMixin, "Setup", function(self)
		self.RewardName:SetTextColor(1, 1, 1)
		self.Icon:SetTexCoord(.08, .92, .08, .92)
		self.Border:SetTexture("")
		self.Border:SetAlpha(0)
		self.Border:Hide()
		if not self.styled then
			F.CreateBDFrame(self.Icon)
			self.styled = true
		end
	end)

	-- Tooltips
	if AuroraConfig.tooltips then
		ContributionTooltip:SetBackdrop(nil)
		ContributionBuffTooltip:DisableDrawLayer("BACKGROUND")
		ContributionBuffTooltip.Icon:SetTexCoord(.08, .92, .08, .92)
		ContributionBuffTooltip.Border:SetTexture("")
		ContributionBuffTooltip.Border:SetAlpha(0)
		ContributionBuffTooltip.Border:Hide()
		F.CreateBDFrame(ContributionTooltip)
		F.CreateBDFrame(ContributionBuffTooltip)
		F.CreateBDFrame(ContributionBuffTooltip.Icon)
	end
end