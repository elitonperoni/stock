import { AppSidebar } from "@/components/app-sidebar";
import { ChartAreaInteractive } from "@/components/chart-area-interactive";
import { DataTable } from "@/components/data-table";
import { SectionCards } from "@/components/section-cards";
import { SiteHeader } from "@/components/site-header";
import { SidebarInset, SidebarProvider } from "@/components/ui/sidebar";

import data from "./data.json";
import { ChartLineInteractive } from "@/components/chart-line-interactive";
import { ChartPieInteractive } from "@/components/chart-pie-interactive";
import { ChartRadialText } from "@/components/char-radial";
import { ChartTooltipDefault } from "@/components/chart-tooltip";
import { ChartBarMultiple } from "@/components/char-bar-multiple";
import { Card, CardContent } from "@/components/ui/card";

export default function Page() {
  return (
    <SidebarProvider
      style={
        {
          "--sidebar-width": "calc(var(--spacing) * 72)",
          "--header-height": "calc(var(--spacing) * 12)",
        } as React.CSSProperties
      }
    >
      <AppSidebar variant="inset" />
      <SidebarInset>
        <SiteHeader />
        <div className="flex flex-1 flex-col">
          <div className="@container/main flex flex-1 flex-col gap-2">
            <div className="flex flex-col gap-4 py-4 md:gap-6 md:py-6">
              <SectionCards />
              <div className="px-4 lg:px-6">
                <ChartAreaInteractive />
              </div>
              <DataTable data={data} />
              <div className="px-4 lg:px-6">
                <ChartLineInteractive />
              </div>             
              <div className="px-4 lg:px-6 grid grid-cols-1 md:grid-cols-2 gap-4">
                <Card className="h-full min-h-[300px] flex flex-col">
                  <CardContent className="flex-1">
                    <ChartPieInteractive />
                  </CardContent>
                </Card>
                <Card className="h-full min-h-[300px] flex flex-col">
                  <CardContent className="flex-1">
                    <ChartRadialText />
                  </CardContent>
                </Card>
                <Card className="h-full min-h-[300px] flex flex-col">
                  <CardContent className="flex-1">
                    <ChartTooltipDefault />
                  </CardContent>
                </Card>
                <Card className="h-full min-h-[300px] flex flex-col">
                  <CardContent className="flex-1">
                    <ChartBarMultiple />
                  </CardContent>
                </Card>
              </div>             
            </div>
          </div>
        </div>
      </SidebarInset>
    </SidebarProvider>
  );
}
