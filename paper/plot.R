full_data <- read_csv(here("data", "data_clean", "full_data.csv"))

hurricane_date <- ymd("1989-09-18")

ggplot(full_data, aes(x = sample_date, y = concentration)) +
  geom_line(aes(linetype = sample_id)) +
  facet_wrap(~ions, ncol = 1, 
             scales = "free_y", 
             strip.position = "left") +
  geom_vline(xintercept = hurricane_date, linetype = "dashed") +
  theme_bw() +
  theme(strip.background = element_blank(),
        strip.placement = "outside",
        strip.text.y.left = element_text(angle = 90),
        axis.title.y = element_blank(),
        panel.spacing = unit(0, "lines"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

ggsave(here("figs", "figure-3.jpg"))
