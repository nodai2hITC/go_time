module GoTime
  refine Time do
    def format(fmt)
      GoTime.format(self, fmt)
    end
  end
end
